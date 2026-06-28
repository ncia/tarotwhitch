import sys

def modify():
    with open('lib/data/tarot_data.dart', 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Replace the fixed path
    content = content.replace("'assets/images/", "'$deckPath/")
    
    # Add deckPath variable at the top of getTarotDeck
    func_start = "List<TarotCardData> getTarotDeck(BuildContext context) {\n  final loc = AppLocalizations.of(context)!;"
    new_func_start = """List<TarotCardData> getTarotDeck(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  String deckPath = 'assets/images';
  if (DeckManager.instance.currentDeck != 'rider_waite') {
    deckPath = 'assets/images/${DeckManager.instance.currentDeck}';
  }"""
    content = content.replace(func_start, new_func_start)
    
    # Add import
    if "import '../services/deck_manager.dart';" not in content:
        content = content.replace("import 'package:flutter_tarot/l10n/app_localizations.dart';", "import 'package:flutter_tarot/l10n/app_localizations.dart';\nimport '../services/deck_manager.dart';")

    with open('lib/data/tarot_data.dart', 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    modify()
