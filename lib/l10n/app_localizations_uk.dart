// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get navReading => 'Читання Таро';

  @override
  String get navChat => 'Таро Чат';

  @override
  String get navMeanings => 'Значення';

  @override
  String get readingIntroTitle => 'Шепоти\nДолі';

  @override
  String get readingIntroSubtitle => 'Таємнича сила чекає на вас...';

  @override
  String get readingIntroButton => 'Дізнайся свою долю';

  @override
  String get readingSpreadTitle => 'Ключ\nДолі';

  @override
  String get readingSpreadSubtitle => 'Ваше особисте читання таро';

  @override
  String get readingSpreadMessageTitle => 'Доля, яка чекає на вас...';

  @override
  String get readingSpreadMessageBody =>
      'Приготуйтеся до несподіваної подорожі, яка принесе як нові випробування, так і великі нагороди.';

  @override
  String get chatTitle => 'Таро Чат';

  @override
  String get chatSubtitle => 'Відкрийте для себе мудрість таро';

  @override
  String get chatName => 'Емілія';

  @override
  String get chatBadge => 'Таро Чат ✨';

  @override
  String get chatPlaceholder => 'Область інтерфейсу чату';

  @override
  String get meaningsTitle => '🃏 Значення карт Таро';

  @override
  String get meaningsSubtitle => 'Зануртеся у світ таро';

  @override
  String get meaningsPlaceholder => 'Область деталей карти';
}
