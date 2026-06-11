// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navReading => 'Чтение Таро';

  @override
  String get navChat => 'Таро Чат';

  @override
  String get navMeanings => 'Значения';

  @override
  String get readingIntroTitle => 'Шепот\nСудьбы';

  @override
  String get readingIntroSubtitle => 'Таинственная сила ждет вас...';

  @override
  String get readingIntroButton => 'Узнай свою судьбу';

  @override
  String get readingSpreadTitle => 'Ключ\nСудьбы';

  @override
  String get readingSpreadSubtitle => 'Ваше личное чтение таро';

  @override
  String get readingSpreadMessageTitle => 'Судьба, которая ждет вас...';

  @override
  String get readingSpreadMessageBody =>
      'Приготовьтесь к неожиданному путешествию, которое принесет как новые испытания, так и большие награды.';

  @override
  String get chatTitle => 'Таро Чат';

  @override
  String get chatSubtitle => 'Откройте для себя мудрость таро';

  @override
  String get chatName => 'Эмилия';

  @override
  String get chatBadge => 'Таро Чат ✨';

  @override
  String get chatPlaceholder => 'Область интерфейса чата';

  @override
  String get meaningsTitle => '🃏 Значения карт Таро';

  @override
  String get meaningsSubtitle => 'Погрузитесь в мир таро';

  @override
  String get meaningsPlaceholder => 'Область деталей карты';
}
