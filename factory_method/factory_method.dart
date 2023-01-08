import 'dart:ffi';

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
