// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get navReading => '타로 리딩';

  @override
  String get navChat => '타로 상담';

  @override
  String get navMeanings => '카드 도감';

  @override
  String get readingIntroTitle => '운명의\n속삭임';

  @override
  String get readingIntroSubtitle => '신비로운 힘이 당신을 기다립니다...';

  @override
  String get readingIntroButton => '운명 확인하기';

  @override
  String get readingSpreadTitle => '운명의\n열쇠';

  @override
  String get readingSpreadSubtitle => '나만의 타로 리딩';

  @override
  String get readingSpreadMessageTitle => '당신의 미래에 다가올 운명은...';

  @override
  String get readingSpreadMessageBody =>
      '새로운 도전과 큰 보상을 동시에 가져다줄 예상치 못한 여정을 준비하세요.';

  @override
  String get chatTitle => '타로 상담';

  @override
  String get chatSubtitle => '타로의 지혜를 발견하세요';

  @override
  String get chatName => '에밀리아';

  @override
  String get chatBadge => '타로 상담 ✨';

  @override
  String get chatPlaceholder => '채팅 인터페이스 영역';

  @override
  String get meaningsTitle => '🃏 타로 카드의 의미';

  @override
  String get meaningsSubtitle => '타로 카드의 깊은 세계로';

  @override
  String get meaningsPlaceholder => '카드 상세 정보 영역';
}
