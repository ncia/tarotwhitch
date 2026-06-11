// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get navReading => 'Tarot Olvasás';

  @override
  String get navChat => 'Tarot Chat';

  @override
  String get navMeanings => 'Jelentések';

  @override
  String get readingIntroTitle => 'A Sors\nSuttogása';

  @override
  String get readingIntroSubtitle => 'Egy titokzatos erő vár rád...';

  @override
  String get readingIntroButton => 'Fedezd fel a sorsod';

  @override
  String get readingSpreadTitle => 'A Sors\nKulcsa';

  @override
  String get readingSpreadSubtitle => 'A te személyes tarot olvasásod';

  @override
  String get readingSpreadMessageTitle => 'A sors, ami rád vár...';

  @override
  String get readingSpreadMessageBody =>
      'Készülj fel egy váratlan utazásra, amely új kihívásokat és nagy jutalmakat is hoz.';

  @override
  String get chatTitle => 'Tarot Chat';

  @override
  String get chatSubtitle => 'Fedezd fel a tarot bölcsességét';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Chat ✨';

  @override
  String get chatPlaceholder => 'Chat felület területe';

  @override
  String get meaningsTitle => '🃏 Tarot Kártyák Jelentései';

  @override
  String get meaningsSubtitle => 'Merülj el a tarot világában';

  @override
  String get meaningsPlaceholder => 'Kártya részletei terület';
}
