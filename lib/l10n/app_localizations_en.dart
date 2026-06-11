// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navReading => 'Reading';

  @override
  String get navChat => 'AI Chat';

  @override
  String get navMeanings => 'Meanings';

  @override
  String get readingIntroTitle => 'Consult the\nSpirits';

  @override
  String get readingIntroSubtitle => 'The mystical forces are waiting...';

  @override
  String get readingIntroButton => 'Consult Spirits';

  @override
  String get readingSpreadTitle => 'Unlock the\nMysteries';

  @override
  String get readingSpreadSubtitle => 'Personal Tarot Readings';

  @override
  String get readingSpreadMessageTitle => 'What awaits you in the future...';

  @override
  String get readingSpreadMessageBody =>
      'Prepare for an unexpected journey that brings both challenge and great reward.';

  @override
  String get chatTitle => 'AI Powered\nTarot Chat';

  @override
  String get chatSubtitle => 'Unlock Your Tarot Insights';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'AI Chat ✨';

  @override
  String get chatPlaceholder => 'Chat Interface Area';

  @override
  String get meaningsTitle => 'Detailed\nMeanings';

  @override
  String get meaningsSubtitle => 'Deep Dive into Tarot Cards';

  @override
  String get meaningsPlaceholder => 'Card Details Area';
}
