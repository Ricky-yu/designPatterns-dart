abstract class Animal {
  Animal clone();
}

class Sheep implements Animal {
  late int _hashCode;
  bool isClone = false;
  String get cloneStatus => isClone ? "is a clone" : "is an original gangster";

  Sheep();

  Sheep.fromSource(Sheep source) {
    _hashCode = source.hashCode;
    isClone = true;
  }

  @override
  Sheep clone() {
    return Sheep.fromSource(this);
  }

  @override
  int get hashCode {
    _hashCode = DateTime.now().millisecondsSinceEpoch;
    return _hashCode;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! Sheep) return false;
    Sheep rect = other;
    return rect.isClone && rect.hashCode == hashCode;
  }
}

class CloneFactory {
  Animal getClone(Animal animalSample) {
    return animalSample.clone();
  }
}

void main() {
  final animalMaker = CloneFactory();
  final sheep = Sheep();
  final clonedSheep = animalMaker.getClone(sheep) as Sheep;
  final someOtherSheep = Sheep();

  print("sheep ${sheep.cloneStatus}.");
  print("clonedSheep ${clonedSheep.cloneStatus}.");
  print("someOtherSheep ${someOtherSheep.cloneStatus}.");

  String cloneIsClone =
      sheep == clonedSheep ? "is a clone of" : "is not a clone of";
  print("clonedSheep $cloneIsClone sheep.");

  String someRectIsClone =
      sheep == someOtherSheep ? "is a clone of" : "is not a clone of";
  print("someOtherSheep $someRectIsClone sheep.");
}
