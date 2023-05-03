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
