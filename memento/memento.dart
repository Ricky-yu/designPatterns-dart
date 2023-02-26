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
