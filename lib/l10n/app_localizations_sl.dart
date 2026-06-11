// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get navReading => 'Branje Tarota';

  @override
  String get navChat => 'Tarot Klepet';

  @override
  String get navMeanings => 'Pomeni';

  @override
  String get readingIntroTitle => 'Šepeti\nUsode';

  @override
  String get readingIntroSubtitle => 'Čaka te skrivnostna moč...';

  @override
  String get readingIntroButton => 'Odkrij svojo usodo';

  @override
  String get readingSpreadTitle => 'Ključ\nUsode';

  @override
  String get readingSpreadSubtitle => 'Tvoje osebno branje tarota';

  @override
  String get readingSpreadMessageTitle => 'Usoda, ki te čaka...';

  @override
  String get readingSpreadMessageBody =>
      'Pripravi se na nepričakovano potovanje, ki bo prineslo nove izzive in velike nagrade.';

  @override
  String get chatTitle => 'Tarot Klepet';

  @override
  String get chatSubtitle => 'Odkrij modrost tarota';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Klepet ✨';

  @override
  String get chatPlaceholder => 'Območje vmesnika za klepet';

  @override
  String get meaningsTitle => '🃏 Pomeni Tarot Kart';

  @override
  String get meaningsSubtitle => 'Potopi se v svet tarota';

  @override
  String get meaningsPlaceholder => 'Območje s podrobnostmi o karti';
}
