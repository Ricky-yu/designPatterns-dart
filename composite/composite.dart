abstract class CarPart {
  String get name;
  int get price;
}

class Part extends CarPart {
  String name;
  int price;

  Part(this.name, this.price);
}

class CompositePart extends CarPart {
  String name;
  List<CarPart> parts;
  CompositePart(this.name, this.parts);

  int get price {
    int subtotal = 0;
    for (final part in parts) {
      subtotal += part.price;
    }
    return subtotal;
  }
}

class CustomerOrder {
  String customer;
  List<CarPart> parts;

  CustomerOrder(this.customer, this.parts);

  int get totalPrice {
    int subtotal = 0;
    for (final part in parts) {
      subtotal += part.price;
      print("${part.name} : ${part.price}");
    }
    return subtotal;
  }

  void printDetails() {
    print("Order for $customer: Cost: $totalPrice");
  }
}

void main() {
  final doorWindow = CompositePart(
      "DoorWindow", [Part("Window", 100), Part("Window Switch", 20)]);
  final door = CompositePart(
      "Door", [doorWindow, Part("Door Loom", 80), Part("Door Handles", 50)]);
  final hood = Part("Hood", 320);
  final order = CustomerOrder("Bob", [doorWindow, door, hood]);
  order.printDetails();
}
