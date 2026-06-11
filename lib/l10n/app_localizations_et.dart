// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get navReading => 'Taro lugemine';

  @override
  String get navChat => 'Taro vestlus';

  @override
  String get navMeanings => 'Tähendused';

  @override
  String get readingIntroTitle => 'Saatuse\nSosistused';

  @override
  String get readingIntroSubtitle => 'Saladuslik jõud ootab sind...';

  @override
  String get readingIntroButton => 'Avasta oma saatus';

  @override
  String get readingSpreadTitle => 'Saatuse\nVõti';

  @override
  String get readingSpreadSubtitle => 'Sinu isiklik taro lugemine';

  @override
  String get readingSpreadMessageTitle => 'Saatus, mis sind ootab...';

  @override
  String get readingSpreadMessageBody =>
      'Valmistu ootamatuks reisiks, mis toob nii uusi väljakutseid kui ka suuri auhindu.';

  @override
  String get chatTitle => 'Taro vestlus';

  @override
  String get chatSubtitle => 'Avasta taro tarkus';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Taro vestlus ✨';

  @override
  String get chatPlaceholder => 'Vestluse liidese ala';

  @override
  String get meaningsTitle => '🃏 Taro Kaartide Tähendused';

  @override
  String get meaningsSubtitle => 'Sukeldu taro maailma';

  @override
  String get meaningsPlaceholder => 'Kaardi üksikasjade ala';
}
