import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeckManager {
  static final DeckManager instance = DeckManager._internal();
  
  DeckManager._internal();

  final ValueNotifier<String> currentDeckNotifier = ValueNotifier<String>('rider_waite');

  String get currentDeck => currentDeckNotifier.value;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    currentDeckNotifier.value = prefs.getString('current_deck') ?? 'rider_waite';
  }

  Future<void> setDeck(String deckId) async {
    currentDeckNotifier.value = deckId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_deck', deckId);
  }
}
