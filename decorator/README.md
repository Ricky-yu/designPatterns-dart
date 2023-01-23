## Decorator Pattern
In object-oriented programming, the decorator pattern is a design pattern that allows behavior to be added to an individual object, dynamically, without affecting the behavior of other objects from the same class. The decorator pattern is often useful for adhering to the Single Responsibility Principle, as it allows functionality to be divided between classes with unique areas of concern. The decorator pattern is structurally nearly identical to the chain of responsibility pattern, the difference being that in a chain of responsibility, exactly one of the classes handles the request, while for the decorator, all classes handle the request.

[Wikipedia: Decorator Pattern](https://en.wikipedia.org/wiki/Decorator_pattern)

[YouTube: Decorator Pattern](https://www.youtube.com/watch?v=GCraGHx6gso&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=3)

``` dart
class Purchase {
  String product;
  int price;
  String get description => product;
  int get totalPrice => price;
  Purchase(this.product, this.price);
}

class CustomerAccount {
  String customerName;
  List<Purchase> _purchases = [];

  CustomerAccount(this.customerName);

  void addPurchase(Purchase purchase) {
    _purchases.add(purchase);
  }

  void printAcoount() {
    var total = 0;
    for (final p in _purchases) {
      total += p.totalPrice;
      print("Purchase ${p.description}, Price ${p.totalPrice}");
    }
    print("Total due : $total");
  }
}

class BasePurchaseDecorator extends Purchase {
  Purchase purchase;
  BasePurchaseDecorator(this.purchase)
      : super(purchase.description, purchase.totalPrice);
}

class PurchaseWithGiftWrap extends BasePurchaseDecorator {
  PurchaseWithGiftWrap(super.purchase);

  @override
  String get description => "${super.description} + giftWrap";

  @override
  int get totalPrice => super.price + 10;
}

class PurchaseWithRibbon extends BasePurchaseDecorator {
  
  PurchaseWithRibbon(super.purchase);

  @override
  String get description => "${super.description} + ribbon";

  @override
  int get totalPrice => super.totalPrice + 5;
}

class PurchaseWithDelivery extends BasePurchaseDecorator {
 
  PurchaseWithDelivery(super.purchase);

  @override
  String get description => "${super.description} + delivery";

  @override
  int get totalPrice => super.totalPrice + 20;
}

void main() {
  final account = CustomerAccount("Joe");

  account.addPurchase(Purchase("Red Hat", 10));
  account.addPurchase(Purchase("Scarf", 20));
  account.addPurchase(
      PurchaseWithDelivery(PurchaseWithGiftWrap(Purchase("Sunglasses", 25))));
  account.printAcoount();
}
```

```
########OUTPUT#########
Purchase Red Hat, Price 10
Purchase Scarf, Price 20
Purchase Sunglasses + giftWrap + delivery, Price 55
Total due : 85
```
