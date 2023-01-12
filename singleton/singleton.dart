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
