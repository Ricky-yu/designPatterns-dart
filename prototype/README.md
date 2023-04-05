## Prototype Pattern
The prototype pattern is a creational design pattern in software development. It is used when the type of objects to create is determined by a prototypical instance, which is cloned to produce new objects.

This pattern is used to:
* avoid subclasses of an object creator in the client application, like the factory method pattern does.
* avoid the inherent cost of creating a new object in the standard way (e.g., using the 'new' keyword) when it is prohibitively expensive for a given application.

To implement the pattern, declare an abstract base class that specifies a pure virtual clone() method. Any class that needs a "polymorphic constructor" capability derives itself from the abstract base class, and implements the clone() operation.

[Wikipedia: Prototype Pattern](https://en.wikipedia.org/wiki/Prototype_pattern)

[YouTube: Prototype Pattern](https://www.youtube.com/watch?v=AFbZhRL0Uz8&ab_channel=DerekBanas)

``` dart 
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
```


```
########## OUTPUT ##############
sheep is an original gangster.
clonedSheep is a clone.
someOtherSheep is an original gangster.

clonedSheep is a clone of sheep.
someOtherSheep is not a clone of sheep.
```
