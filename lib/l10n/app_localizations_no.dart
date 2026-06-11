// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get navReading => 'Tarotlesning';

  @override
  String get navChat => 'Tarot Chat';

  @override
  String get navMeanings => 'Betydninger';

  @override
  String get readingIntroTitle => 'Skjebnens\nVisking';

  @override
  String get readingIntroSubtitle => 'En mystisk makt venter på deg...';

  @override
  String get readingIntroButton => 'Oppdag din skjebne';

  @override
  String get readingSpreadTitle => 'Skjebnens\nNøkkel';

  @override
  String get readingSpreadSubtitle => 'Din personlige tarotlesning';

  @override
  String get readingSpreadMessageTitle => 'Skjebnen som venter deg...';

  @override
  String get readingSpreadMessageBody =>
      'Forbered deg på en uventet reise som vil bringe både nye utfordringer og store belønninger.';

  @override
  String get chatTitle => 'Tarot Chat';

  @override
  String get chatSubtitle => 'Oppdag tarots visdom';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Chat ✨';

  @override
  String get chatPlaceholder => 'Chat-grensesnitt område';

  @override
  String get meaningsTitle => '🃏 Tarotkort Betydninger';

  @override
  String get meaningsSubtitle => 'Dyk ned i tarotverdenen';

  @override
  String get meaningsPlaceholder => 'Kortdetalj område';
}
