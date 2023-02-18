## Interpreter Pattern
In computer programming, the interpreter pattern is a design pattern that specifies how to evaluate sentences in a language. The basic idea is to have a class for each symbol (terminal or nonterminal) in a specialized computer language. The syntax tree of a sentence in the language is an instance of the composite pattern and is used to evaluate (interpret) the sentence for a client. 

[Wikipedia: Interpreter Pattern](https://en.wikipedia.org/wiki/Interpreter_pattern)

[YouTube: Interpreter Pattern](https://www.youtube.com/watch?v=6CVymSJQuJE&ab_channel=DerekBanas)

``` dart
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
```

```
#####OUTPUT#######
Adding 100...
Subtracting 60...
Adding 10...
And the result is 50!
```
