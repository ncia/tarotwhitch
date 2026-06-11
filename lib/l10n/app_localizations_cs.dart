// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get navReading => 'Výklad Tarotu';

  @override
  String get navChat => 'Tarot Chat';

  @override
  String get navMeanings => 'Významy';

  @override
  String get readingIntroTitle => 'Šepoty\nOsudu';

  @override
  String get readingIntroSubtitle => 'Čeká na tebe tajemná síla...';

  @override
  String get readingIntroButton => 'Objev svůj osud';

  @override
  String get readingSpreadTitle => 'Klíč\nOsudu';

  @override
  String get readingSpreadSubtitle => 'Tvůj osobní výklad tarotu';

  @override
  String get readingSpreadMessageTitle => 'Osud, který tě čeká...';

  @override
  String get readingSpreadMessageBody =>
      'Připrav se na nečekanou cestu, která přinese jak nové výzvy, tak velké odměny.';

  @override
  String get chatTitle => 'Tarot Chat';

  @override
  String get chatSubtitle => 'Objev moudrost tarotu';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Chat ✨';

  @override
  String get chatPlaceholder => 'Oblast chatovacího rozhraní';

  @override
  String get meaningsTitle => '🃏 Významy Tarotových Karet';

  @override
  String get meaningsSubtitle => 'Ponoř se do světa tarotu';

  @override
  String get meaningsPlaceholder => 'Oblast detailů karty';
}
