## Facade Pattern
The facade pattern (also spelled façade) is a software-design pattern commonly used in object-oriented programming. Analogous to a facade in architecture, a facade is an object that serves as a front-facing interface masking more complex underlying or structural code.

The facade pattern is typically used when:
* a simple interface is required to access a complex system,
* a system is very complex or difficult to understand,
* an entry point is needed to each level of layered software, or
* the abstractions and implementations of a subsystem are tightly coupled.

[Wikipedia: Facade Pattern](https://en.wikipedia.org/wiki/Facade_pattern)

[YouTube: Facade Pattern](https://www.youtube.com/watch?v=K4FkHVO5iac&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=10)

``` dart
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
```

```
########## OUTPUT ##############
Grinding Coffee!
prepareLargeCup
brewCoffee
fillWater
Done
Grinding Coffee!
prepareSmallCup
brewCoffee
fillMlik
milkFrothing
Done
```
