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
