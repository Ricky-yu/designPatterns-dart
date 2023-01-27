## State Pattern
The state pattern is used in computer programming to encapsulate varying behavior for the same object, based on its internal state. This can be a cleaner way for an object to change its behavior at runtime without resorting to conditional statements and thus improve maintainability.

[Wikipedia: State Pattern](https://en.wikipedia.org/wiki/State_pattern)

[Youtube: State Pattern](https://www.youtube.com/watch?v=N12L5D78MAA&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=17)

``` dart
abstract class State {
  void handler(Stateful context);
  String toString();
}

class StatusOn implements State {
  handler(Stateful context) {
    print("  Handler of StatusOn is being called!");
    context.state = StatusOff();
  }

  @override
  String toString() {
    return "on";
  }
}

class StatusOff implements State {
  handler(Stateful context) {
    print("  Handler of StatusOff is being called!");
    context.state = StatusOn();
  }

  @override
  String toString() {
    return "off";
  }
}

class Stateful {
  State _state;

  Stateful(this._state);

  State get state => _state;
  set state(State newState) => _state = newState;

  void touch() {
    print("  Touching the Stateful...");
    _state.handler(this);
  }
}

void main() {
  var lightSwitch = Stateful(StatusOff());
  print("The light state is ${lightSwitch.state}.");
  print("Toggling the light switch");
  lightSwitch.touch();
  print("The light state is ${lightSwitch.state}.");
  lightSwitch.touch();
  print("The light state is ${lightSwitch.state}.");
}
```

```
######OUTPUT#######
The light state is off.
Toggling the light switch
  Touching the Stateful...
  Handler of StatusOff is being called!
The light state is on.
  Touching the Stateful...
  Handler of StatusOn is being called!
The light state is off.
```


