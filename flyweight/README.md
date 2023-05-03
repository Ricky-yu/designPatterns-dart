## Flyweight Pattern
In computer programming, flyweight is a software design pattern. A flyweight is an object that minimizes memory usage by sharing as much data as possible with other similar objects; it is a way to use objects in large numbers when a simple repeated representation would use an unacceptable amount of memory. Often some parts of the object state can be shared, and it is common practice to hold them in external data structures and pass them to the objects temporarily when they are used.

A classic example usage of the flyweight pattern is the data structures for graphical representation of characters in a word processor. It might be desirable to have, for each character in a document, a glyph object containing its font outline, font metrics, and other formatting data, but this would amount to hundreds or thousands of bytes for each character. Instead, for every character there might be a reference to a flyweight glyph object shared by every instance of the same character in the document; only the position of each character (in the document and/or the page) would need to be stored internally.

Another example is string interning.

In other contexts the idea of sharing identical data structures is called hash consing.

[Wikipedia: Flyweight Pattern](https://en.wikipedia.org/wiki/Flyweight_pattern)

[YouTube: Flyweight Pattern](https://www.youtube.com/watch?v=0vV-R2926ss&ab_channel=DerekBanas)

``` dart
import 'dart:collection';
import 'dart:math';

abstract class Employee {
  void assignSkill(String skill);
  void task();
}

class Developer implements Employee {
  final String JOB = "Fix the issue";
  String skill = "";

  @override
  void assignSkill(String skill) {
    this.skill = skill;
  }

  @override
  void task() => print("Developer with skill: " + this.skill + " with Job: " + JOB);
  
}

class Tester implements Employee {
  final String JOB = "Test the issue";
  String skill = "";

  @override
  void assignSkill(String skill) {
    this.skill = skill;
  }

  @override
  void task() =>
      print("Tester with Skill: " + this.skill + " with Job: " + JOB);
}

class EmployeeFactory {
  static HashMap<String, Employee> m = new HashMap<String, Employee>();

  static Employee getEmployee(String type) {
    Employee? p = null;

    if (m[type] != null) {
      p = m[type];
    } else {
      switch (type) {
        case "Developer":
          print("Developer Created");
          p = Developer();
          break;
        case "Tester":
          print("Tester Created");
          p = Tester();
          break;
        default:
          print("No Such Employee");
      }
      m[type] = p!;
    }
    return p!;
  }
}

void main() {
  final employeeType = ["Developer", "Tester"];
  final skills = ["Java", "C++", ".Net", "Python"];

  for (int i = 0; i < 10; i++) {
    final r = Random();
    int randInt = r.nextInt(employeeType.length);

    Employee e = EmployeeFactory.getEmployee(employeeType[randInt]);

    randInt = r.nextInt(skills.length);

    e.assignSkill(skills[randInt]);
    e.task();
  }
}
```

```
#######OUTPUT#######
Tester Created
Tester with Skill: C++ with Job: Test the issue
Tester with Skill: Java with Job: Test the issue
Tester with Skill: Python with Job: Test the issue
Developer Created
Developer with skill: C++ with Job: Fix the issue
Tester with Skill: .Net with Job: Test the issue
Developer with skill: C++ with Job: Fix the issue
Tester with Skill: Python with Job: Test the issue
Tester with Skill: Java with Job: Test the issue
Tester with Skill: Java with Job: Test the issue
Tester with Skill: .Net with Job: Test the issue
```
