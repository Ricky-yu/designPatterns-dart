## Memento Pattern
The memento pattern is a software design pattern that provides the ability to restore an object to its previous state (undo via rollback).

The memento pattern is implemented with three objects: the originator, a caretaker and a memento. The originator is some object that has an internal state. The caretaker is going to do something to the originator, but wants to be able to undo the change. The caretaker first asks the originator for a memento object. Then it does whatever operation (or sequence of operations) it was going to do. To roll back to the state before the operations, it returns the memento object to the originator. The memento object itself is an opaque object (one which the caretaker cannot, or should not, change). When using this pattern, care should be taken if the originator may change other objects or resources - the memento pattern operates on a single object.

[Wikipedia: Memento Pattern](https://en.wikipedia.org/wiki/Memento_pattern)

[YouTube: Memento Pattern](https://www.youtube.com/watch?v=jOnxYT8Iaoo&ab_channel=DerekBanas)

``` dart 
class LedgerEntry {
  final int id;
  final String counterParty;
  final int amuount;

  LedgerEntry(this.id, this.counterParty, this.amuount);
}

class LedgerMemento {
  late final List<LedgerEntry> entries;
  late final int total;
  late final int nextId;

  LedgerMemento(LedgerOriginator ledger) {
    this.entries = ledger.entries.values.toList();
    this.total = ledger.total;
    this.nextId = ledger.nextid;
  }

  void apply(LedgerOriginator ledger) {
    ledger.total = this.total;
    ledger.nextid = this.nextId;
    ledger.entries = {};
    for (final entry in this.entries) {
      ledger.entries[entry.id] = entry;
    }
  }
}

class LedgerOriginator {
  Map<int, LedgerEntry> entries = {};
  int nextid = 1;
  int total = 0;

  void addEntry(String counterParty, int amuout) {
    final entry = LedgerEntry(nextid++, counterParty, amuout);
    entries[entry.id] = entry;
    total += amuout;
  }

  LedgerMemento saveMemento() => LedgerMemento(this);

  void applyMemento(LedgerMemento memento) => memento.apply(this);

  void printEntries() {
    for (final id in entries.keys.toList()) {
      final entry = entries[id];
      if (entry != null) {
        print("$id: ${entry.counterParty} ${entry.amuount}");
      }
    }
    print("Total: $total");
    print("--------");
  }
}

class LedgerCaretaker {
  List<LedgerMemento> memento = [];
  void saveMemento(LedgerOriginator ledger) =>
      memento.add(ledger.saveMemento());
}

void main() {
  final ledger = LedgerOriginator();
  final caretaker = LedgerCaretaker();

  ledger.addEntry("Bob", 100);
  caretaker.saveMemento(ledger);

  ledger.addEntry("Joe", 200);
  caretaker.saveMemento(ledger);

  ledger.addEntry("Alice", 500);
  caretaker.saveMemento(ledger);

  ledger.addEntry("Tony", 20);

  ledger.printEntries();

  ledger.applyMemento(caretaker.memento.first);

  ledger.printEntries();

  ledger.applyMemento(caretaker.memento.last);

  ledger.printEntries();
}
```
```
#######OUTPUT######
1: Bob 100
2: Joe 200
3: Alice 500
4: Tony 20
Total: 820
--------
1: Bob 100
Total: 100
--------
1: Bob 100
2: Joe 200
3: Alice 500
Total: 800
--------
```
