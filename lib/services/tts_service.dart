import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart' hide AudioSource;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import '../data/witch_data.dart';
import 'audio_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;

  AudioPlayer? _audioPlayer;
  String get _apiKey => dotenv.env['SPEECHIFY_API_KEY'] ?? '';
  final String _baseUrl = 'https://api.speechify.ai/v1/audio/speech';
  
  final List<String> _textQueue = [];
  bool _isPlaying = false;
  Witch? _currentWitch;
  String _currentLocale = 'ko';

  bool get _isWindows => !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  SoundHandle? _soloudTtsHandle;

  TtsService._internal() {
    if (!_isWindows) {
      _audioPlayer = AudioPlayer();
      _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _playNextInQueue();
        }
      });
    }
  }

  Future<void> speak(Witch witch, String text, String localeCode) async {
    stop();
    WakelockPlus.enable();
    _currentWitch = witch;
    _currentLocale = localeCode;
    _textQueue.add(text);
    _playNextInQueue();
  }

  Future<void> speakLongText(Witch witch, String text, String localeCode) async {
    stop();
    WakelockPlus.enable();
    _currentWitch = witch;
    _currentLocale = localeCode;
    
    // Split into paragraphs to respect API limits and provide natural pauses
    final paragraphs = text.split('\n');
    for (var p in paragraphs) {
      final clean = p.trim();
      if (clean.isNotEmpty) {
        if (clean.length > 300) {
           final sentences = clean.split(RegExp(r'(?<=[.!?])\s+'));
           for (var s in sentences) {
             if (s.trim().isNotEmpty) _textQueue.add(s.trim());
           }
        } else {
           _textQueue.add(clean);
        }
      }
    }
    
    _playNextInQueue();
  }

  Future<void> _playNextInQueue() async {
    if (AudioService().isMuted || AudioService().volume == 0) {
      _textQueue.clear();
      _isPlaying = false;
      WakelockPlus.disable();
      AudioService().resumeBgm();
      return;
    }

    if (_textQueue.isEmpty) {
      _isPlaying = false;
      WakelockPlus.disable();
      AudioService().resumeBgm();
      return;
    }

    _isPlaying = true;
    final text = _textQueue.removeAt(0);

    try {
      final requestBody = jsonEncode({
        'input': text,
        'voice_id': _currentWitch!.speechifyVoiceId,
        'audio_format': 'mp3',
        'model': 'simba-multilingual',
        'language': _currentLocale
      });

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String base64Audio = responseData['audio_data'] ?? '';
        
        if (base64Audio.isEmpty) {
          print('Speechify API Error: No audio_data found in response');
          return;
        }

        final Uint8List audioBytes = base64Decode(base64Audio);
        
        final tempDir = await getTemporaryDirectory();
        final String safePath = '${tempDir.path}${Platform.pathSeparator}tts_temp_${DateTime.now().millisecondsSinceEpoch}.mp3';
        final tempFile = File(safePath);
        await tempFile.writeAsBytes(audioBytes);
        
        print('Saved TTS MP3 to: $safePath, Size: ${audioBytes.length} bytes');

        await AudioService().pauseBgm();
        final double ttsVolume = AudioService().isMuted ? 0.0 : 0.5;
        final double playbackRate = _currentWitch?.id == 'karen' ? 0.85 : 1.0;

        if (_isWindows) {
          final source = await SoLoud.instance.loadFile(safePath);
          _soloudTtsHandle = SoLoud.instance.play(source, volume: ttsVolume);
          
          // Wait for completion via length
          final length = SoLoud.instance.getLength(source);
          await Future.delayed(length);
          _playNextInQueue();
        } else {
          await _audioPlayer!.setSpeed(playbackRate);
          if (_currentWitch?.id == 'karen') {
             await _audioPlayer!.setPitch(0.9);
          } else {
             await _audioPlayer!.setPitch(1.0);
          }
          await _audioPlayer!.setVolume(ttsVolume);
          await _audioPlayer!.setFilePath(safePath);
          await _audioPlayer!.play();
        }
      } else {
        print('Speechify API Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        _playNextInQueue();
      }
    } catch (e) {
      print('Error during Speechify TTS synthesis: $e');
      _playNextInQueue();
    }
  }

  void stop() {
    _textQueue.clear();
    _isPlaying = false;
    
    if (_isWindows) {
      if (_soloudTtsHandle != null) {
        SoLoud.instance.stop(_soloudTtsHandle!);
      }
    } else {
      _audioPlayer?.stop();
    }
    
    WakelockPlus.disable();
    AudioService().resumeBgm();
  }
}
