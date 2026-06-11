// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get navReading => 'Tarotlæsning';

  @override
  String get navChat => 'Tarot Chat';

  @override
  String get navMeanings => 'Betydninger';

  @override
  String get readingIntroTitle => 'Skæbnens\nHvisken';

  @override
  String get readingIntroSubtitle => 'En mystisk magt venter på dig...';

  @override
  String get readingIntroButton => 'Opdag din skæbne';

  @override
  String get readingSpreadTitle => 'Skæbnens\nNøgle';

  @override
  String get readingSpreadSubtitle => 'Din personlige tarotlæsning';

  @override
  String get readingSpreadMessageTitle => 'Skæbnen, der venter dig...';

  @override
  String get readingSpreadMessageBody =>
      'Forbered dig på en uventet rejse, der vil bringe både nye udfordringer og store belønninger.';

  @override
  String get chatTitle => 'Tarot Chat';

  @override
  String get chatSubtitle => 'Opdag tarottens visdom';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Chat ✨';

  @override
  String get chatPlaceholder => 'Chat grænseflade område';

  @override
  String get meaningsTitle => '🃏 Tarotkortenes Betydning';

  @override
  String get meaningsSubtitle => 'Dyk ned i tarottens verden';

  @override
  String get meaningsPlaceholder => 'Kort detaljeområde';
}
