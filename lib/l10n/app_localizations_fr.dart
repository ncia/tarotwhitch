// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navReading => 'Lecture de Tarot';

  @override
  String get navChat => 'Chat de Tarot';

  @override
  String get navMeanings => 'Significations';

  @override
  String get readingIntroTitle => 'Murmures du\nDestin';

  @override
  String get readingIntroSubtitle => 'Un pouvoir mystérieux vous attend...';

  @override
  String get readingIntroButton => 'Découvrez votre destin';

  @override
  String get readingSpreadTitle => 'Clé du\nDestin';

  @override
  String get readingSpreadSubtitle => 'Votre lecture de tarot personnelle';

  @override
  String get readingSpreadMessageTitle => 'Le destin qui vous attend...';

  @override
  String get readingSpreadMessageBody =>
      'Préparez-vous à un voyage inattendu qui apportera à la fois de nouveaux défis et de grandes récompenses.';

  @override
  String get chatTitle => 'Chat de Tarot';

  @override
  String get chatSubtitle => 'Découvrez la sagesse du tarot';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Chat de Tarot ✨';

  @override
  String get chatPlaceholder => 'Zone de l\'interface de chat';

  @override
  String get meaningsTitle => '🃏 Significations des Cartes';

  @override
  String get meaningsSubtitle => 'Plongez dans le monde du tarot';

  @override
  String get meaningsPlaceholder => 'Zone de détails des cartes';
}
