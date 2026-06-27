import 'package:just_audio/just_audio.dart' hide AudioSource;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'tts_service.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  
  AudioService._internal();

  AudioPlayer? _bgmPlayer;
  AudioPlayer? _sfxPlayer;

  bool _isBgmPlaying = false;
  bool _isMuted = false;
  double _volume = 0.5;

  final ValueNotifier<bool> isMutedNotifier = ValueNotifier<bool>(false);

  bool get isMuted => _isMuted;
  double get volume => _volume;

  bool get _isWindows => !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  // SoLoud instances for Windows
  AudioSource? _soloudBgmSource;
  SoundHandle? _soloudBgmHandle;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = prefs.getBool('is_muted') ?? false;
    isMutedNotifier.value = _isMuted;

    if (_isWindows) {
      await SoLoud.instance.init();
      _soloudBgmSource = await SoLoud.instance.loadAsset('assets/audio/bgm.mp3');
      return;
    }

    _bgmPlayer = AudioPlayer();
    _sfxPlayer = AudioPlayer();

    await _bgmPlayer!.setLoopMode(LoopMode.one);
    await _bgmPlayer!.setAsset('assets/audio/bgm.mp3');
    await _bgmPlayer!.setVolume(_isMuted ? 0.0 : _volume);
  }

  Future<void> playMysteriousBgm() async {
    if (_isBgmPlaying) return;
    try {
      if (_isWindows) {
        if (_soloudBgmSource != null) {
          _soloudBgmHandle = SoLoud.instance.play(
            _soloudBgmSource!,
            volume: _isMuted ? 0.0 : _volume,
            looping: true,
          );
          _isBgmPlaying = true;
        }
        return;
      }
      
      await _bgmPlayer!.setVolume(_isMuted ? 0.0 : _volume);
      await _bgmPlayer!.play();
      _isBgmPlaying = true;
    } catch (e) {
      print("Error playing BGM: $e");
    }
  }

  Future<void> stopBgm() async {
    if (!_isBgmPlaying) return;
    try {
      if (_isWindows) {
        if (_soloudBgmHandle != null) {
          SoLoud.instance.stop(_soloudBgmHandle!);
        }
        _isBgmPlaying = false;
        return;
      }

      await _bgmPlayer!.stop();
      _isBgmPlaying = false;
    } catch (e) {
      print("Error stopping BGM: $e");
    }
  }

  Future<void> playThunderSound() async {
    if (_isMuted) return;
    try {
      if (_isWindows) {
        final source = await SoLoud.instance.loadAsset('assets/audio/thunder.ogg');
        SoLoud.instance.play(source, volume: _volume * 2.0);
        return;
      }

      await _sfxPlayer!.setAsset('assets/audio/thunder.ogg');
      await _sfxPlayer!.setVolume(_volume * 2.0);
      await _sfxPlayer!.play();
    } catch (e) {
      print("Error playing thunder sound: $e");
    }
  }

  Future<void> pauseBgm() async {
    if (!_isBgmPlaying) return;
    try {
      if (_isWindows) {
        if (_soloudBgmHandle != null) {
          SoLoud.instance.setPause(_soloudBgmHandle!, true);
        }
        _isBgmPlaying = false;
        return;
      }

      await _bgmPlayer!.pause();
      _isBgmPlaying = false;
    } catch (e) {
      print("Error pausing BGM: $e");
    }
  }

  Future<void> resumeBgm() async {
    try {
      if (_isWindows) {
        if (_soloudBgmHandle != null) {
          SoLoud.instance.setPause(_soloudBgmHandle!, false);
        } else {
          playMysteriousBgm();
        }
        _isBgmPlaying = true;
        return;
      }

      await _bgmPlayer!.play();
      _isBgmPlaying = true;
    } catch (e) {
      print("Error resuming BGM: $e");
    }
  }

  Future<void> playCardFlipSfx() async {
    try {
      // Optional: Add a flip sound effect later
      // await _sfxPlayer!.setAsset('assets/audio/flip.mp3');
      // await _sfxPlayer!.play();
    } catch (e) {
      print("Error playing SFX: $e");
    }
  }

  Future<void> setVolume(double vol) async {
    _volume = vol;
    if (!_isMuted) {
      if (_isWindows) {
        if (_soloudBgmHandle != null) {
          SoLoud.instance.setVolume(_soloudBgmHandle!, _volume);
        }
        return;
      }
      await _bgmPlayer!.setVolume(_volume);
    }
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    isMutedNotifier.value = _isMuted;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_muted', _isMuted);

    if (_isMuted) {
      if (_isWindows) {
        if (_soloudBgmHandle != null) SoLoud.instance.setVolume(_soloudBgmHandle!, 0.0);
      } else {
        await _bgmPlayer!.setVolume(0.0);
      }
      TtsService().stop();
    } else {
      if (_isWindows) {
        if (_soloudBgmHandle != null) SoLoud.instance.setVolume(_soloudBgmHandle!, _volume);
      } else {
        await _bgmPlayer!.setVolume(_volume);
      }
    }
  }
  
  void dispose() {
    if (_isWindows) {
      SoLoud.instance.deinit();
      return;
    }
    _bgmPlayer?.dispose();
    _sfxPlayer?.dispose();
  }
}
