// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get navReading => 'Tarot-luenta';

  @override
  String get navChat => 'Tarot-keskustelu';

  @override
  String get navMeanings => 'Merkitykset';

  @override
  String get readingIntroTitle => 'Kohtalon\nKuiskaus';

  @override
  String get readingIntroSubtitle => 'Salaperäinen voima odottaa sinua...';

  @override
  String get readingIntroButton => 'Löydä kohtalosi';

  @override
  String get readingSpreadTitle => 'Kohtalon\nAvain';

  @override
  String get readingSpreadSubtitle => 'Henkilökohtainen tarot-luentasi';

  @override
  String get readingSpreadMessageTitle => 'Kohtalo, joka odottaa sinua...';

  @override
  String get readingSpreadMessageBody =>
      'Valmistaudu odottamattomalle matkalle, joka tuo mukanaan uusia haasteita ja suuria palkintoja.';

  @override
  String get chatTitle => 'Tarot-keskustelu';

  @override
  String get chatSubtitle => 'Löydä tarotin viisaus';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot-keskustelu ✨';

  @override
  String get chatPlaceholder => 'Keskustelukäyttöliittymäalue';

  @override
  String get meaningsTitle => '🃏 Tarot-korttien Merkitykset';

  @override
  String get meaningsSubtitle => 'Sukella tarotin maailmaan';

  @override
  String get meaningsPlaceholder => 'Kortin yksityiskohdat';
}
