class Purchase {
  String product;
  int price;
  String get description => product;
  int get totalPrice => price;

  Purchase(this.product, this.price);
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

void main() {
  final account = CustomerAccount("Joe");

  account.addPurchase(Purchase("Red Hat", 10));
  account.addPurchase(Purchase("Scarf", 20));
  account.addPurchase(
      PurchaseWithDelivery(PurchaseWithGiftWrap(Purchase("Sunglasses", 25))));
  account.printAcoount();
}
