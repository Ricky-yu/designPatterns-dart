## Mediator Pattern
In software engineering, the mediator pattern defines an object that encapsulates how a set of objects interact. This pattern is considered to be a behavioral pattern due to the way it can alter the program's running behavior.

Usually a program is made up of a large number of classes. Logic and computation are distributed among these classes. However, as more classes are added to a program, especially during maintenance and/or refactoring, the problem of communication between these classes may become more complex. This makes the program harder to read and maintain. Furthermore, it can become difficult to change the program, since any change may affect code in several other classes.

With the mediator pattern, communication between objects is encapsulated within a mediator object. Objects no longer communicate directly with each other, but instead communicate through the mediator. This reduces the dependencies between communicating objects, thereby reducing coupling.

[Wikipedia: Mediator Pattern](https://en.wikipedia.org/wiki/Mediator_pattern)

[YouTube: Mediator Pattern](https://www.youtube.com/watch?v=8DxIpdKd41A&ab_channel=DerekBanas)

``` dart
class StockOffer {
  int stockShares = 0;
  String stockSymbol = "";
  int colleagueCode = 0;

  StockOffer(this.stockShares, this.stockSymbol, this.colleagueCode);
}

abstract class Colleague {
  Mediator mediator;
  late int colleagueCode;

  Colleague(this.mediator) {
    mediator.addColleague(this);
  }

  void saleOffer(String stock, int shares) =>
      mediator.saleOffer(stock, shares, this.colleagueCode);

  void buyOffer(String stock, int shares) =>
      mediator.buyOffer(stock, shares, this.colleagueCode);
}

class GormanSlacks extends Colleague {
  GormanSlacks(Mediator newMediator) : super(newMediator) {
    print("Gorman Slacks signed up with the stockexchange");
  }
}

class JTPoorman extends Colleague {
  JTPoorman(Mediator newMediator) : super(newMediator) {
    print("JT Poorman signed up with the stockexchange");
  }
}

abstract class Mediator {
  void saleOffer(String stock, int shares, int collCode);

  void buyOffer(String stock, int shares, int collCode);

  void addColleague(Colleague colleague);
}

class StockMediator implements Mediator {
  List<Colleague> colleagues = [];
  List<StockOffer> stockBuyOffers = [];
  List<StockOffer> stockSaleOffers = [];

  void addColleague(Colleague newColleague) {
    colleagues.add(newColleague);
    newColleague.colleagueCode = colleagues.length;
  }

  void saleOffer(String stock, int shares, int collCode) => _execute(stock, shares, collCode, isbuy: false);

  void buyOffer(String stock, int shares, int collCode) => _execute(stock, shares, collCode, isbuy: true);

  void _execute(String stock, int shares, int collCode, {required bool isbuy}) {
    bool stockInventory = false;

    for (StockOffer offer in stockSaleOffers) {
      stockInventory =
          (offer.stockSymbol == stock) && (offer.stockShares == shares);
      if (stockInventory) {
        isbuy
            ? print(
                "$shares shares of $stock  bought by colleague code ${offer.colleagueCode}")
            : print(
                "$shares shares of $stock sold to colleague code ${offer.colleagueCode}");

        stockSaleOffers.remove(offer);
        break;
      }
    }

    if (!stockInventory) {
      print("$shares shares of $stock added to inventory");

      final newOffering = StockOffer(shares, stock, collCode);
      isbuy
          ? stockBuyOffers.add(newOffering)
          : stockSaleOffers.add(newOffering);
    }
  }

  void getstockOfferings() {
    print("Stocks for Sale");

    for (final offer in stockSaleOffers) {
      print("${offer.stockShares} of ${offer.stockSymbol}");
    }

    print("Stock Buy Offers");

    for (final offer in stockBuyOffers) {
      print("${offer.stockShares} of ${offer.stockSymbol}");
    }
  }
}

void main() {
  final spx500 = StockMediator();
  final broker1 = GormanSlacks(spx500);
  final broker2 = JTPoorman(spx500);

  broker1.saleOffer("AAPL", 100);
  broker1.saleOffer("ORCL", 50);

  broker2.buyOffer("AAPL", 100);
  broker2.saleOffer("JPM", 10);

  broker1.buyOffer("SBUX", 10);

  spx500.getstockOfferings();
}
```

```
#######OUTPUT#######
Gorman Slacks signed up with the stockexchange
JT Poorman signed up with the stockexchange
100 shares of AAPL added to inventory
50 shares of ORCL added to inventory
100 shares of AAPL  bought by colleague code 1
10 shares of JPM added to inventory
10 shares of SBUX added to inventory
Stocks for Sale
50 of ORCL
10 of JPM
Stock Buy Offers
10 of SBUX
```
