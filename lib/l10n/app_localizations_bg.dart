// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get navReading => 'Четене на Таро';

  @override
  String get navChat => 'Таро Чат';

  @override
  String get navMeanings => 'Значения';

  @override
  String get readingIntroTitle => 'Шепоти на\nСъдбата';

  @override
  String get readingIntroSubtitle => 'Тайнствена сила ви очаква...';

  @override
  String get readingIntroButton => 'Открий съдбата си';

  @override
  String get readingSpreadTitle => 'Ключ на\nСъдбата';

  @override
  String get readingSpreadSubtitle => 'Вашето лично четене на таро';

  @override
  String get readingSpreadMessageTitle => 'Съдбата, която ви очаква...';

  @override
  String get readingSpreadMessageBody =>
      'Пригответе се за неочаквано пътуване, което ще донесе както нови предизвикателства, така и големи награди.';

  @override
  String get chatTitle => 'Таро Чат';

  @override
  String get chatSubtitle => 'Открийте мъдростта на таро';

  @override
  String get chatName => 'Емилия';

  @override
  String get chatBadge => 'Таро Чат ✨';

  @override
  String get chatPlaceholder => 'Зона на чат интерфейса';

  @override
  String get meaningsTitle => '🃏 Значения на Таро Картите';

  @override
  String get meaningsSubtitle => 'Потопете се в света на таро';

  @override
  String get meaningsPlaceholder => 'Зона с детайли за картата';
}
