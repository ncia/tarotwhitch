// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get navReading => 'Tarot Okuması';

  @override
  String get navChat => 'Tarot Sohbeti';

  @override
  String get navMeanings => 'Anlamlar';

  @override
  String get readingIntroTitle => 'Kaderin\nFısıltıları';

  @override
  String get readingIntroSubtitle => 'Gizemli bir güç seni bekliyor...';

  @override
  String get readingIntroButton => 'Kaderini Keşfet';

  @override
  String get readingSpreadTitle => 'Kaderin\nAnahtarı';

  @override
  String get readingSpreadSubtitle => 'Kişisel tarot okuman';

  @override
  String get readingSpreadMessageTitle => 'Seni bekleyen kader...';

  @override
  String get readingSpreadMessageBody =>
      'Hem yeni zorluklar hem de büyük ödüller getirecek beklenmedik bir yolculuğa hazırlan.';

  @override
  String get chatTitle => 'Tarot Sohbeti';

  @override
  String get chatSubtitle => 'Tarot\'un bilgeliğini keşfet';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Tarot Sohbeti ✨';

  @override
  String get chatPlaceholder => 'Sohbet arayüzü alanı';

  @override
  String get meaningsTitle => '🃏 Tarot Kartı Anlamları';

  @override
  String get meaningsSubtitle => 'Tarot dünyasının derinliklerine in';

  @override
  String get meaningsPlaceholder => 'Kart detay alanı';
}
