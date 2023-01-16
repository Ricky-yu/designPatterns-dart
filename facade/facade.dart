class Grinder {
  void grind() {
    print("Grinding Coffee!");
  }
}

class Maker {
  void brewCoffee() {
    print("brewCoffee");
  }

  void fillWater() {
    print("fillWater");
  }

  void fillMlik() {
    print("fillMlik");
  }

  void milkFrothing() {
    print("milkFrothing");
  }
}

class Cup {
  void prepareSmallCup() {
    print("prepareSmallCup");
  }

  void prepareBigCup() {
    print("prepareLargeCup");
  }
}

enum CupSize {
  small,
  big,
}

class CoffeeFacade {
  final _coffeeGrinder = Grinder();
  final _coffeeMaker = Maker();
  final _cup = Cup();

  void makeAmeriano(CupSize size) {
    _coffeeGrinder.grind();
    if (size == CupSize.big) {
      _cup.prepareBigCup();
    } else {
      _cup.prepareSmallCup();
    }
    _coffeeMaker
      ..brewCoffee()
      ..fillWater();
    print("Done");
  }

  void makeLatte(CupSize size) {
    _coffeeGrinder.grind();
    if (size == CupSize.big) {
      _cup.prepareBigCup();
    } else {
      _cup.prepareSmallCup();
    }
    _coffeeMaker
      ..brewCoffee()
      ..fillMlik()
      ..milkFrothing();
    print("Done");
  }
}

void main() {
  final _coffeeFacade = CoffeeFacade();
  _coffeeFacade.makeAmeriano(CupSize.big);
  _coffeeFacade.makeLatte(CupSize.small);
}
