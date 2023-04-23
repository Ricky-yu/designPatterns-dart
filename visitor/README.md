# Visitor Pattern
The visitor design pattern is a way of separating an algorithm from an object structure on which it operates. A practical result of this separation is the ability to add new operations to existent object structures without modifying the structures. It is one way to follow the open/closed principle.

In essence, the visitor allows adding new virtual functions to a family of classes, without modifying the classes. Instead, a visitor class is created that implements all of the appropriate specializations of the virtual function. The visitor takes the instance reference as input, and implements the goal through double dispatch.


[Wikipedia: Visitor](https://en.wikipedia.org/wiki/Visitor_pattern)

[YouTube: Visitor](https://www.youtube.com/watch?v=pL4mOUDi54o&ab_channel=DerekBanas)

``` dart
abstract class Visitor {
  double liquorVisit(Liquor liquorItem);

  double tobaccoVisit(Tobacco tobaccoItem);

  double necessityVisit(Necessity necessityItem);
}

class TaxVisitor implements Visitor {
  double liquorVisit(Liquor liquorItem) => liquorItem.price * 0.9;

  double tobaccoVisit(Tobacco tobaccoItem) => tobaccoItem.price * 0.8;

  double necessityVisit(Necessity necessityItem) => necessityItem.price;
}

class TaxHolidayVisitor implements Visitor {
  double liquorVisit(Liquor liquorItem) => liquorItem.price * 0.8;

  double tobaccoVisit(Tobacco tobaccoItem) => tobaccoItem.price * 0.7;

  double necessityVisit(Necessity necessityItem) => necessityItem.price * 0.9;
}

abstract class Visitable {
  double accept(Visitor visitor);
}

class Liquor implements Visitable {
  double price;

  Liquor({required this.price});

  double accept(Visitor visitor) => visitor.liquorVisit(this);
}

class Tobacco implements Visitable {
  double price;

  Tobacco({required this.price});

  double accept(Visitor visitor) => visitor.tobaccoVisit(this);

}

class Necessity implements Visitable {
  double price;

  Necessity({required this.price});

  double accept(Visitor visitor) => visitor.necessityVisit(this);
}

void main() {
  TaxVisitor taxCalc = new TaxVisitor();

  TaxHolidayVisitor taxHolidayCalc = new TaxHolidayVisitor();

  Necessity milk = new Necessity(price: 200);

  Liquor vodka = new Liquor(price: 1200);

  Tobacco cigars = new Tobacco(price: 800);

  print(milk.accept(taxCalc));
  print(vodka.accept(taxCalc));
  print(cigars.accept(taxCalc));
  print("TAX HOLIDAY PRICES\n");
  print(milk.accept(taxHolidayCalc));
  print(vodka.accept(taxHolidayCalc));
  print(cigars.accept(taxHolidayCalc));
}
```

```
########OUTPUT#######
200.0
1080.0
640.0
TAX HOLIDAY PRICES
180.0
960.0
560.0
```
