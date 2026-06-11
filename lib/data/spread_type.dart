enum SpreadType {
  oneCard,
  threeCard,
  celticCross,
}

extension SpreadTypeExtension on SpreadType {
  int get cardCount {
    switch (this) {
      case SpreadType.oneCard:
        return 1;
      case SpreadType.threeCard:
        return 3;
      case SpreadType.celticCross:
        return 10;
    }
  }
}
