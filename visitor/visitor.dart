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

  double getPrice() => price;
}

class Tobacco implements Visitable {
  double price;

  Tobacco({required this.price});

  double accept(Visitor visitor) => visitor.tobaccoVisit(this);

  double getPrice() => price;
}

class Necessity implements Visitable {
  double price;

  Necessity({required this.price});

  double accept(Visitor visitor) => visitor.necessityVisit(this);

  double getPrice() => price;
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
