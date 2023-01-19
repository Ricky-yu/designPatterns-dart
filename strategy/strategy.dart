abstract class Strategy {
  int execute(List<int> values);
}

class SumStrategy implements Strategy {
  @override
  int execute(List<int> values) {
    return values.reduce((value1, value2) => value1 + value2);
  }
}

class MultiplyStrategy implements Strategy {
  @override
  int execute(List<int> values) {
    return values.reduce((value1, value2) => value1 * value2);
  }
}

class Sequence {
  List<int> numbers;

  Sequence(this.numbers);

  void addNumber(int value) {
    numbers.add(value);
  }

  int compute(Strategy strategy) {
    return strategy.execute(numbers);
  }
}

void main() {
  Sequence sequence = Sequence([1, 2, 3, 4, 5]);

  Strategy sumStrategy = SumStrategy();
  print("Sum: ${sequence.compute(sumStrategy)}");

  Strategy multiplyStrategy = MultiplyStrategy();
  print("Multiply: ${sequence.compute(multiplyStrategy)}");
}
