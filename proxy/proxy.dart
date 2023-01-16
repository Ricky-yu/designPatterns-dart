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
