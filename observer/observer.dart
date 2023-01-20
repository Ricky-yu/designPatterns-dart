abstract class Observer {
  void notify(String user, bool success);
}

class ActivityLog implements Observer {
  @override
  void notify(String user, bool success) {
    logActivity("Auth request for $user. Success: $success");
  }

  void logActivity(String activity) {
    print("Log: $activity");
  }
}

class FileCache implements Observer {
  @override
  void notify(String user, bool success) {
    if (success) {
      loadFiles(user);
    }
  }

  void loadFiles(String user) {
    print("Load filse for $user");
  }
}

class AttackMonitor implements Observer {
  @override
  void notify(String user, bool success) {
    final monitorSuspiciousActivity = !success;
    print("Monitoring for attack: $monitorSuspiciousActivity");
  }
}

class ObservableSubject {
  List<Observer> _observers = [];
  
  void addObservers(List<Observer> observers) {
    observers.forEach((element) {
      _observers.add(element);
    });
  }

  void removeObserver(Observer observer) {
    _observers = _observers.where((element) => element != observer).toList();
  }

  void sendNotification(String user, bool success) {
    for (final ob in _observers) {
      ob.notify(user, success);
    }
  }
}

class AuthenticationManager extends ObservableSubject  {
  bool authenticate(String user, String pass) {
    var result = false;
    if (user == "Admin" && pass == "Admin") {
      result = true;
      print("User $user is authenticated");
    } else {
      print("failed authentication attempt");
    }
    sendNotification(user, result);
    return result;
  }
}

void main() {
  final log = ActivityLog();
  final cache = FileCache();
  final monitor = AttackMonitor();

  final authManager = AuthenticationManager();
  authManager.addObservers([log, cache, monitor]);

  authManager.authenticate("Admin", "Admin");
  print("-------");
  authManager.authenticate("Guest", "123");
  print("-------");
  authManager.removeObserver(log);
  authManager.authenticate("Admin", "Admin");
}
