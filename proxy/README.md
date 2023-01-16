## Proxy Pattern
A proxy, in its most general form, is a class functioning as an interface to something else. The proxy could interface to anything: a network connection, a large object in memory, a file, or some other resource that is expensive or impossible to duplicate. In short, a proxy is a wrapper or agent object that is being called by the client to access the real serving object behind the scenes.

[Wikipedia: Proxy Pattern](https://en.wikipedia.org/wiki/Proxy_pattern)

[YouTube: Proxy Pattern](https://www.youtube.com/watch?v=NwaabHqPHeM&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=10&ab_channel=ChristopherOkhravi)

``` dart
abstract class DatabaseExecuter {
  void executeDatabase(String query);
}

class DatabaseExecuterImpl implements DatabaseExecuter {
  @override
  void executeDatabase(String query) {
    print("Going to execute Query: $query");
  }
}

class DatabaseExecuterProxy implements DatabaseExecuter {
  bool _isAdmin = false;
  late DatabaseExecuterImpl _databaseExecuterImpl;
  DatabaseExecuterProxy(String name, String password) {
    if (name == "Admin" && password == "Admin") {
      _isAdmin = true;
    }
    _databaseExecuterImpl = DatabaseExecuterImpl();
  }

  @override
  void executeDatabase(String query) {
    if (_isAdmin) {
      _databaseExecuterImpl.executeDatabase(query);
    } else {
      if (query == "DELETE") {
        print("DELETE not allowed for non-admin user");
      } else {
        _databaseExecuterImpl.executeDatabase(query);
      }
    }
  }
}

void main() {
  DatabaseExecuterProxy executer = DatabaseExecuterProxy("Guest", "Guest");
  executer.executeDatabase("DELETE");

  DatabaseExecuterProxy adminExecuter = DatabaseExecuterProxy("Admin", "Admin");
  adminExecuter.executeDatabase("DELETE");
}
```

```
######## OUTPUT ##################
DELETE not allowed for non-admin user
Going to execute Query: DELETE
```
