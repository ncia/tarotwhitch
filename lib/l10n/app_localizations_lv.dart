// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get navReading => 'Taro Lasīšana';

  @override
  String get navChat => 'Taro Tērzēšana';

  @override
  String get navMeanings => 'Nozīmes';

  @override
  String get readingIntroTitle => 'Likteņa\nČuksti';

  @override
  String get readingIntroSubtitle => 'Mnoslēpumains spēks tevi gaida...';

  @override
  String get readingIntroButton => 'Atklāj savu likteni';

  @override
  String get readingSpreadTitle => 'Likteņa\nAtslēga';

  @override
  String get readingSpreadSubtitle => 'Tavs personīgais taro lasījums';

  @override
  String get readingSpreadMessageTitle => 'Liktenis, kas tevi gaida...';

  @override
  String get readingSpreadMessageBody =>
      'Sagatavojies negaidītam ceļojumam, kas nesīs gan jaunus izaicinājumus, gan lielu atalgojumu.';

  @override
  String get chatTitle => 'Taro Tērzēšana';

  @override
  String get chatSubtitle => 'Atklāj taro gudrību';

  @override
  String get chatName => 'Emīlija';

  @override
  String get chatBadge => 'Taro Tērzēšana ✨';

  @override
  String get chatPlaceholder => 'Tērzēšanas interfeisa zona';

  @override
  String get meaningsTitle => '🃏 Taro Kārtis Nozīmes';

  @override
  String get meaningsSubtitle => 'Ienirsti taro pasaulē';

  @override
  String get meaningsPlaceholder => 'Kārts detaļu zona';
}
