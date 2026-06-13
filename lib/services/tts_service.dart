import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import '../data/witch_data.dart';
import 'audio_service.dart';

class TtsService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String _scopes = 'https://www.googleapis.com/auth/cloud-platform';
  final String _apiUrl = 'https://texttospeech.googleapis.com/v1/text:synthesize';
  
  TtsService() {
    // 음성 재생이 자연스럽게 끝났을 때 BGM 다시 재생
    _audioPlayer.onPlayerComplete.listen((event) {
      AudioService().resumeBgm();
    });
  }

  /// 캐릭터의 설정에 맞추어 텍스트를 음성으로 변환하고 재생합니다.
  Future<void> speak(Witch witch, String text, String localeCode) async {
    try {
      final String keyString = await rootBundle.loadString('assets/data/gen-lang-client-0060702917-14b71d4afd12.json');
      final serviceAccountCredentials = ServiceAccountCredentials.fromJson(keyString);
      final client = await clientViaServiceAccount(serviceAccountCredentials, [_scopes]);
      
      final isKorean = localeCode == 'ko';
      final isEnglish = localeCode == 'en';
      
      String languageCode = isKorean ? 'ko-KR' : (isEnglish ? 'en-US' : localeCode);
      String? voiceName;
      
      if (isKorean) {
        voiceName = witch.ttsVoiceName;
      } else if (isEnglish) {
        if (witch.id == 'morgan' || witch.id == 'evelyn') {
          voiceName = 'en-US-Neural2-F';
        } else if (witch.id == 'luna' || witch.id == 'aria') {
          voiceName = 'en-US-Neural2-H';
        } else {
          voiceName = 'en-US-Neural2-E';
        }
      }

      final Map<String, dynamic> voiceConfig = {
        'languageCode': languageCode,
      };
      if (voiceName != null) {
        voiceConfig['name'] = voiceName;
      }

      // 3. API 요청 바디(Payload) 생성
      final requestBody = jsonEncode({
        'input': {
          'text': text,
        },
        'voice': voiceConfig,
        'audioConfig': {
          'audioEncoding': 'MP3',
          'pitch': witch.ttsPitch,
          'speakingRate': witch.ttsSpeakingRate,
        }
      });

      // 4. 구글 TTS 서버로 POST 요청 전송
      final response = await client.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      // 통신이 끝난 클라이언트는 닫아줍니다.
      client.close();

      // 5. 응답 처리 및 재생
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String audioContentBase64 = responseData['audioContent'];
        
        // Base64 문자열을 바이트 배열(Uint8List)로 디코딩
        final Uint8List audioBytes = base64Decode(audioContentBase64);

        // BytesSource를 이용해 즉시 재생
        await AudioService().pauseBgm(); // TTS 시작 직전 BGM 일시정지
        await _audioPlayer.play(BytesSource(audioBytes));
      } else {
        print('Google TTS API Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during TTS synthesis: $e');
    }
  }

  /// 재생 중인 오디오를 중지합니다.
  void stop() {
    _audioPlayer.stop();
    AudioService().resumeBgm(); // 강제 종료 시 BGM 다시 재생
  }
}
