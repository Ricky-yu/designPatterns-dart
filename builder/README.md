## Builder Pattern
The intent of the Builder design pattern is to separate the construction of a complex object from its representation. By doing so the same construction process can create different representations.

[Wikipedia: Builder Pattern](https://en.wikipedia.org/wiki/Builder_pattern)

[YouTube: Builder Pattern](https://www.youtube.com/watch?v=M7Xi1yO_s8E)

``` dart
class Burger {
  String customerName;
  int patties;
  bool pickles;
  bool ketchup;
  bool lettuce;
  Burger(this.customerName, this.patties, this.pickles, this.ketchup,
      this.lettuce);
  void printDescription() {
    print("Name: $customerName");
    print("Patties: $patties");
    print("Pickles: $pickles");
    print("Ketchup: $ketchup");
    print("Lettuce: $lettuce");
  }
}

class BurgerBuilder {
  int _patties = 2;
  bool _pickles = true;
  bool _ketchup = true;
  bool _lettuce = true;

  void setPickles(bool choice) => _pickles = choice;
  void setKetchup(bool choice) => _ketchup = choice;
  void setLettuce(bool choice) => _lettuce = choice;
  void addPatty(bool choice) => _patties = choice ? 3 : 2;

  Burger buildObject(String name) {
    return Burger(name, _patties, _pickles, _ketchup, _lettuce);
  }
}

void main() {
  var builder = BurgerBuilder();

  final name = "Joe";

  builder.setKetchup(false);
  builder.setLettuce(false);

  builder.addPatty(true);

  final oreder = builder.buildObject(name);

  oreder.printDescription();
}
```
```
#####OUTPUT########
Name: Joe
Patties: 3
Pickles: true
Ketchup: false
Lettuce: false
```
