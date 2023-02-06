class ColorsIterator implements Iterator {
  var _colors = [
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Indigo",
    "Violet"
  ];

  var _index = 0;

  @override
  get current => _colors[_index++];

  @override
  bool moveNext() => _index < _colors.length;
}

void main() {
  final colors = ColorsIterator();
  while (colors.moveNext()) {
    print(colors.current);
  }
}
