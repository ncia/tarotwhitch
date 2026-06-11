// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navReading => 'タロット占い';

  @override
  String get navChat => 'タロット相談';

  @override
  String get navMeanings => 'カード図鑑';

  @override
  String get readingIntroTitle => '運命の\n囁き';

  @override
  String get readingIntroSubtitle => '神秘的な力があなたを待っています...';

  @override
  String get readingIntroButton => '運命を確認する';

  @override
  String get readingSpreadTitle => '運命の\n鍵';

  @override
  String get readingSpreadSubtitle => 'あなただけのタロット占い';

  @override
  String get readingSpreadMessageTitle => 'あなたの未来に訪れる運命は...';

  @override
  String get readingSpreadMessageBody => '新たな挑戦と大きな報酬を同時にもたらす予期せぬ旅に備えてください。';

  @override
  String get chatTitle => 'タロット相談';

  @override
  String get chatSubtitle => 'タロットの知恵を発見してください';

  @override
  String get chatName => 'エミリア';

  @override
  String get chatBadge => 'タロット相談 ✨';

  @override
  String get chatPlaceholder => 'チャットインターフェース領域';

  @override
  String get meaningsTitle => '🃏 タロットカードの意味';

  @override
  String get meaningsSubtitle => 'タロットカードの深い世界へ';

  @override
  String get meaningsPlaceholder => 'カード詳細情報領域';
}
