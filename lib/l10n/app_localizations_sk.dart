// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get navReading => 'Výklad Tarotu';

  @override
  String get navChat => 'Tarot Chat';

  @override
  String get navMeanings => 'Významy';

  @override
  String get readingIntroTitle => 'Šepoty\nOsudu';

  @override
  String get readingIntroSubtitle => 'Čaká na teba tajomná sila...';

  @override
  String get readingIntroButton => 'Objav svoj osud';

  @override
  String get readingSpreadTitle => 'Kľúč\nOsudu';

  @override
  String get readingSpreadSubtitle => 'Tvoj osobný výklad tarotu';

  @override
  String get readingSpreadMessageTitle => 'Osud, ktorý ťa čaká...';

  @override
  String get readingSpreadMessageBody =>
      'Priprav sa na nečakanú cestu, ktorá prinesie nové výzvy aj veľké odmeny.';

  @override
  String get chatTitle => 'Tarot Chat';

  @override
  String get chatSubtitle => 'Objav múdrosť tarotu';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Chat ✨';

  @override
  String get chatPlaceholder => 'Oblasť chatovacieho rozhrania';

  @override
  String get meaningsTitle => '🃏 Významy Tarotových Kariet';

  @override
  String get meaningsSubtitle => 'Ponor sa do sveta tarotu';

  @override
  String get meaningsPlaceholder => 'Oblasť detailov karty';
}
