## Observer Pattern
The observer pattern is a software design pattern in which an object, called the subject, maintains a list of its dependents, called observers, and notifies them automatically of any state changes, usually by calling one of their methods.

It is mainly used to implement distributed event handling systems, in "event driven" software. Most modern languages such as C# have built-in "event" constructs which implement the observer pattern components.

The observer pattern is also a key part in the familiar model–view–controller (MVC) architectural pattern. The observer pattern is implemented in numerous programming libraries and systems, including almost all GUI toolkits.

[Wikipedia: Observer Pattner](https://en.wikipedia.org/wiki/Observer_pattern)

[YouTube: Observer Pattner](https://www.youtube.com/watch?v=_BpmfnqjgzQ&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=2&ab_channel=ChristopherOkhravi)

```dart
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
```

```
#######OUTPUT#########
User Admin is authenticated
Log: Auth request for Admin. Success: true
Load filse for Admin
Monitoring for attack: false
-------
failed authentication attempt
Log: Auth request for Guest. Success: false
Monitoring for attack: true
-------
User Admin is authenticated
Load filse for Admin
Monitoring for attack: false
```
