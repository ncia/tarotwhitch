// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get navReading => 'Čitanje Tarota';

  @override
  String get navChat => 'Tarot Chat';

  @override
  String get navMeanings => 'Značenja';

  @override
  String get readingIntroTitle => 'Šapati\nSudbine';

  @override
  String get readingIntroSubtitle => 'Misteriozna moć te čeka...';

  @override
  String get readingIntroButton => 'Otkrij svoju sudbinu';

  @override
  String get readingSpreadTitle => 'Ključ\nSudbine';

  @override
  String get readingSpreadSubtitle => 'Tvoje osobno čitanje tarota';

  @override
  String get readingSpreadMessageTitle => 'Sudbina koja te čeka...';

  @override
  String get readingSpreadMessageBody =>
      'Pripremi se za neočekivano putovanje koje će donijeti nove izazove i velike nagrade.';

  @override
  String get chatTitle => 'Tarot Chat';

  @override
  String get chatSubtitle => 'Otkrij mudrost tarota';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Chat ✨';

  @override
  String get chatPlaceholder => 'Područje sučelja chata';

  @override
  String get meaningsTitle => '🃏 Značenja Tarot Karata';

  @override
  String get meaningsSubtitle => 'Uroni duboko u svijet tarota';

  @override
  String get meaningsPlaceholder => 'Područje s detaljima karte';
}
