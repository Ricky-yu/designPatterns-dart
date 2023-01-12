## Singleton Pattern
In software engineering, the singleton pattern is a software design pattern that restricts the instantiation of a class to one "single" instance. This is useful when exactly one object is needed to coordinate actions across the system. The term comes from the mathematical concept of a singleton.

* The abstract factory, builder, and prototype patterns can use singletons in their implementation.
* Facade objects are often singletons because only one facade object is required.
* State objects are often singletons.

Singletons are often preferred to global variables because:
* They do not pollute the global namespace (or, in languages with nested namespaces, their containing namespace) with unnecessary variables.[4]
* They permit lazy allocation and initialization, whereas global variables in many languages will always consume resources.

[Wikipedia: Singleton Pattern](https://en.wikipedia.org/wiki/Singleton_pattern)

[YouTube: Singleton Pattern](https://www.youtube.com/watch?v=hUE_j6q0LTQ&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=6&ab_channel=ChristopherOkhravi)

``` dart
class Logger {
  static Logger _singleton = Logger._internal();
  List<String> _data = [];
  Logger._internal() {
    print('PRIVATE CONSTRUCTOR RAN');
  }

  factory Logger() {
    return _singleton;
  }

  void log(String msg) {
    _data.add(msg);
  }

  void printLog() {
    for (String msg in _data) {
      print("Log: $msg");
    }
  }
}

void main() {
  var log = Logger();
  var log2 = Logger();
  log.log("crate new ServerA");
  log2.log("crate new ServerB");
  log.printLog();
  log2.printLog();
}
```
