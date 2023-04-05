## Factory Method Pattern
The factory method pattern is a creational pattern that uses factory methods to deal with the problem of creating objects without having to specify the exact class of the object that will be created. This is done by creating objects by calling a factory method—either specified in an interface and implemented by child classes, or implemented in a base class and optionally overridden by derived classes—rather than by calling a constructor.

[Wikipedia: Factory Method](https://en.wikipedia.org/wiki/Factory_method_pattern)

[YouTube: Factory Method](https://www.youtube.com/watch?v=EcFVTgRHJLM&ab_channel=ChristopherOkhravi)

```dart
abstract class RentalCar {
  late String name;
  late int passengers;
  late int pricePerDay;
  RentalCar(this.name, this.passengers, this.pricePerDay);
}

class Compact extends RentalCar {
  Compact() : super('VW Golf', 3, 20);
}

class Sports extends RentalCar {
  Sports() : super('Porsche Boxter', 1, 100);
}

class SUV extends RentalCar {
  SUV() : super('Cadillac Escalade', 8, 75);
}

class RentalCarFactory {
  static RentalCar? createRentalCar({required int passengers}) {
    RentalCar? car;
    if (passengers <= 1) {
      car = Sports();
    } else if (passengers <= 3) {
      car = Compact();
    } else if (passengers <= 8) {
      car = SUV();
    } else {
      car = null;
    }
    return car;
  }
}

void main() {
  String selectCar({required int passengers}) {
    RentalCar? car;
    car = RentalCarFactory.createRentalCar(passengers: passengers);
    return car != null ? car.name : "";
  }

  int calculatePrice({required int passengers, required int days}) {
    RentalCar? car;
    car = RentalCarFactory.createRentalCar(passengers: passengers);
    int pricePerDay = car != null ? car.pricePerDay : 0;
    return pricePerDay * days;
  }

  List<int> passengers = [1, 3, 5];
  List<int> days = [2, 5, 3];

  for (int i = 0; i < passengers.length; i++) {
    print(
        "${passengers[i]} passengers: ${selectCar(passengers: passengers[i])} price: ${calculatePrice(passengers: passengers[i], days: days[i])}");
  }
}
```

```
#####OUTPUT#######
1 passengers: Porsche Boxter price: 200
3 passengers: VW Golf price: 100
5 passengers: Cadillac Escalade price: 225
```
