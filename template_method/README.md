## Template Method Pattern
In object-oriented programming, the template method is one of the behavioral design patterns identified by Gamma et al. in the book Design Patterns. The template method is a method in a superclass, usually an abstract superclass, and defines the skeleton of an operation in terms of a number of high-level steps. These steps are themselves implemented by additional helper methods in the same class as the template method.

The helper methods may be either abstract methods, for which case subclasses are required to provide concrete implementations, or hook methods, which have empty bodies in the superclass. Subclasses can (but are not required to) customize the operation by overriding the hook methods. The intent of the template method is to define the overall structure of the operation, while allowing subclasses to refine, or redefine, certain steps.

[Wikipedia: Template Method Pattern](https://en.wikipedia.org/wiki/Template_method_pattern)

[Youtube: Template Method Pattern](https://www.youtube.com/watch?v=7ocpwK9uesw&t=1554s)

``` dart
abstract class Abstract {
  void prepareRecipe() {
    boilWater();
    brew();
    pourInCup();
    if (customeWantsCondiments()) {
      addCondiments();
    }
  }

  void brew();
  void addCondiments();

  void boilWater() => print("boilWater");
  void pourInCup() => print("pourInCup");
  bool customeWantsCondiments() => true;
}

class Tea extends Abstract {
  bool _customeWantsCondiments = true;

  Tea() : super();

  @override
  void addCondiments() => print("add Lemon");

  @override
  void brew() => print("brew a pot of tea");

  @override
  bool customeWantsCondiments() => _customeWantsCondiments;
}

class Coffee extends Abstract {
  bool _customeWantsCondiments = true;

  Coffee() : super();

  @override
  void addCondiments() => print("add Milk and sugar");

  @override
  void brew() => print("brew a pot of coffee");

  @override
  bool customeWantsCondiments() => _customeWantsCondiments;
}

void main() {
  Tea tea = Tea();
  tea.prepareRecipe();
  print("---------------");
  Coffee coffee = Coffee();
  coffee._customeWantsCondiments = false;
  coffee.prepareRecipe();
}
```

```
#######OUTPUT########
boilWater
brew a pot of tea
pourInCup
add Lemon
---------------
boilWater
brew a pot of coffee
pourInCup
```
