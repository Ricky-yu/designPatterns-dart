class Number {
  late int value;
  Number(int value) {
    this.value = value;
  }
}

abstract class Expression {
  late Number number;
  void interpret(int value);
}

class Add implements Expression {
  Number number;
  Add(this.number);
  void interpret(int value) {
    print("Adding $value...");
    number.value += value;
  }
}

class Subtract implements Expression {
  Number number;
  Subtract(this.number);
  void interpret(int value) {
    print("Subtracting $value...");
    number.value -= value;
  }
}

void main() {
  var number = Number(0);
  var adder = Add(number);
  var subtracter = Subtract(number);

  adder.interpret(100);
  subtracter.interpret(60);
  adder.interpret(10);

  print("And the result is ${number.value}!");
}
