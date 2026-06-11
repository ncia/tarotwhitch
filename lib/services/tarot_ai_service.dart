import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TarotAiService {
  late final GenerativeModel _model;

  TarotAiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception('GEMINI_API_KEY is not defined in .env');
    }
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );
  }

  Stream<String> getTarotReadingStream(String question, List<String> cards) async* {
    final prompt = '''
당신은 신비롭고 지혜로운 타로 마녀 '모건'입니다. 친절하면서도 통찰력 있는 말투를 사용하세요.
내담자(사용자)가 고민을 말하고 타로 카드 3장을 뽑았습니다.

[내담자의 고민]
$question

[뽑은 타로 카드 3장 (이름 및 방향)]
1. ${cards[0]}
2. ${cards[1]}
3. ${cards[2]}

이 3장의 카드의 의미를 연결하여 내담자의 고민에 대한 타로 리딩 결과를 제공해 주세요.
카드의 해석은 The Tarot Guide (thetarotguide.com)의 정통 라이더 웨이트 해석 방식을 적극 참고하여, 카드의 정방향(Upright)과 역방향(Reversed)의 의미를 매우 정확하고 깊이 있게 반영해 주세요.
역방향 점괘가 나왔을 경우 맹목적으로 부정적으로 해석하기보다는, 문제를 인지하고 극복할 수 있는 긍정적이고 희망적인 조언으로 풀어내어 내담자에게 위로와 방향성을 제시해 주세요.
답변은 너무 길지 않게 3~4문단 정도로 작성하며, 마크다운을 최대한 자제하고 순수 텍스트로 부드럽게 대화하듯 이야기해 주세요.
''';

    try {
      final content = [Content.text(prompt)];
      final responseStream = _model.generateContentStream(content);
      await for (final chunk in responseStream) {
        if (chunk.text != null) {
          yield chunk.text!;
        }
      }
    } catch (e) {
      yield '점괘를 읽는 도중 오류가 발생했습니다: $e';
    }
  }
}
