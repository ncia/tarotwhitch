// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navReading => 'Lectura de Tarot';

  @override
  String get navChat => 'Consulta de Tarot';

  @override
  String get navMeanings => 'Guía de Cartas';

  @override
  String get readingIntroTitle => 'Susurros\ndel Destino';

  @override
  String get readingIntroSubtitle => 'Un poder misterioso te espera...';

  @override
  String get readingIntroButton => 'Descubre tu Destino';

  @override
  String get readingSpreadTitle => 'La Llave\ndel Destino';

  @override
  String get readingSpreadSubtitle => 'Tu lectura de tarot personal';

  @override
  String get readingSpreadMessageTitle => 'El destino que te espera...';

  @override
  String get readingSpreadMessageBody =>
      'Prepárate para un viaje inesperado que traerá tanto nuevos desafíos como grandes recompensas.';

  @override
  String get chatTitle => 'Consulta de Tarot';

  @override
  String get chatSubtitle => 'Descubre la sabiduría del tarot';

  @override
  String get chatName => 'Emilia';

  @override
  String get chatBadge => 'Consulta ✨';

  @override
  String get chatPlaceholder => 'Área de interfaz de chat';

  @override
  String get meaningsTitle => '🃏 Significado de las Cartas';

  @override
  String get meaningsSubtitle => 'Adéntrate en el mundo del tarot';

  @override
  String get meaningsPlaceholder => 'Área de detalles de la carta';
}
