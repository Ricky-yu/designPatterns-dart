## Command Pattern
In object-oriented programming, the command pattern is a behavioral design pattern in which an object is used to encapsulate all information needed to perform an action or trigger an event at a later time. This information includes the method name, the object that owns the method and values for the method parameters.

Four terms always associated with the command pattern are command, receiver, invoker and client.

A command object knows about receiver and invokes a method of the receiver. Values for parameters of the receiver method are stored in the command.

The receiver object to execute these methods is also stored in the command object by aggregation. The receiver then does the work when the execute() method in command is called.

An invoker object knows how to execute a command, and optionally does bookkeeping about the command execution. The invoker does not know anything about a concrete command, it knows only about the command interface.

Invoker object(s), command objects and receiver objects are held by a client object, the client decides which receiver objects it assigns to the command objects, and which commands it assigns to the invoker. The client decides which commands to execute at which points. To execute a command, it passes the command object to the invoker object.

Using command objects makes it easier to construct general components that need to delegate, sequence or execute method calls at a time of their choosing without the need to know the class of the method or the method parameters. Using an invoker object allows bookkeeping about command executions to be conveniently performed, as well as implementing different modes for commands, which are managed by the invoker object, without the need for the client to be aware of the existence of bookkeeping or modes.

[Wikipedia: Command Pattern](https://en.wikipedia.org/wiki/Command_pattern)

[YouTube: Command Pattern](https://www.youtube.com/watch?v=9qA5kw8dcSU&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=8&ab_channel=ChristopherOkhravi)

``` dart
class Light {
  String _location;

  Light(this._location);

  void turnOff() => print("$_location Light off!");
  void turnOn() => print("$_location Light on!");
}

enum Speed {
  off('off'),
  low('low'),
  high('high');

  const Speed(this.name);
  final String name;
}

class CeilingFan {
  String _location;
  Speed _speed = Speed.off;
  Speed _prevSpeed = Speed.off;
  CeilingFan(this._location);

  void setHigh() {
    _prevSpeed = getSpeed();
    _speed = Speed.high;
    print("$_location CeilingFan's speed is ${_speed.name}");
  }

  void setLow() {
    _prevSpeed = getSpeed();
    _speed = Speed.low;
    print("$_location CeilingFan's speed is ${_speed.name}");
  }

  void setOff() {
    _prevSpeed = getSpeed();
    _speed = Speed.off;
    print("$_location CeilingFan's is off");
  }

  Speed getSpeed() {
    return _speed;
  }

  void undo() {
    if (_prevSpeed == Speed.high) {
      setHigh();
    } else if (_prevSpeed == Speed.low) {
      setLow();
    } else {
      setOff();
    }
  }
}

abstract class Command {
  void excute();
  void undo();
}

class LightOnCommand implements Command {
  Light _light;
  LightOnCommand(this._light);

  @override
  void excute() {
    _light.turnOn();
  }

  @override
  void undo() {
    _light.turnOff();
  }
}

class LightOffCommand implements Command {
  Light _light;
  LightOffCommand(this._light);

  @override
  void excute() {
    _light.turnOff();
  }

  @override
  void undo() {
    _light.turnOn();
  }
}

class CeilingFanHighCommand implements Command {
  CeilingFan _ceilingFan;
  CeilingFanHighCommand(this._ceilingFan);

  @override
  void excute() {
    _ceilingFan.setHigh();
  }

  @override
  void undo() {
    _ceilingFan.undo();
  }
}

class CeilingFanLowCommand implements Command {
  CeilingFan _ceilingFan;
  CeilingFanLowCommand(this._ceilingFan);

  @override
  void excute() {
    _ceilingFan.setLow();
  }

  @override
  void undo() {
    _ceilingFan.undo();
  }
}

class CeilingFanOffCommand implements Command {
  CeilingFan _ceilingFan;
  CeilingFanOffCommand(this._ceilingFan);

  @override
  void excute() {
    _ceilingFan.setOff();
  }

  @override
  void undo() {
    _ceilingFan.undo();
  }
}

class RemoteControl {
  List<Command> _onCommands = [];
  List<Command> _offCommands = [];
  Command? _undoCommand;

  int setCommand({onCommand, offCommand}) {
    _onCommands.add(onCommand);
    _offCommands.add(offCommand);
    return _onCommands.length - 1;
  }

  void onButtonWasPushed(int shot) {
    _onCommands[shot].excute();
    _undoCommand = _onCommands[shot];
  }

  void offButtonWasPushed(int shot) {
    _offCommands[shot].excute();
    _undoCommand = _offCommands[shot];
  }

  void undoButtonWasPushed() {
    if (_undoCommand != null) {
      _undoCommand!.undo();
    }
  }
}

void main() {
  Light livingRoomLight = Light("living Room");
  LightOnCommand livingRoomLightOnCommand = LightOnCommand(livingRoomLight);
  LightOffCommand livingRoomLightOffCommand = LightOffCommand(livingRoomLight);

  Light kitchenLight = Light("kitchen");
  LightOnCommand kitchenLightOnCommand = LightOnCommand(kitchenLight);
  LightOffCommand kitchenLightOffCommand = LightOffCommand(kitchenLight);

  CeilingFan livingRoomCeilingFan = CeilingFan("living Room");
  CeilingFanHighCommand livingRoomCeilingFanHighCommand =
      CeilingFanHighCommand(livingRoomCeilingFan);
  CeilingFanLowCommand livingRoomCeilingFanLowCommand =
      CeilingFanLowCommand(livingRoomCeilingFan);
  CeilingFanOffCommand livingRoomCeilingFanOffCommand =
      CeilingFanOffCommand(livingRoomCeilingFan);

  RemoteControl remoteControl = RemoteControl();

  int livingRoomLightButtonIndex = remoteControl.setCommand(
      onCommand: livingRoomLightOnCommand,
      offCommand: livingRoomLightOffCommand);
  int kitchenLightButtonIndex = remoteControl.setCommand(
      onCommand: kitchenLightOnCommand, offCommand: kitchenLightOffCommand);

  int livingRoomCeilingFanHighButtonIndex = remoteControl.setCommand(
      onCommand: livingRoomCeilingFanHighCommand,
      offCommand: livingRoomCeilingFanOffCommand);
  int livingRoomCeilingFanLowButtonIndex = remoteControl.setCommand(
      onCommand: livingRoomCeilingFanLowCommand,
      offCommand: livingRoomCeilingFanOffCommand);

  remoteControl.onButtonWasPushed(livingRoomLightButtonIndex);
  remoteControl.onButtonWasPushed(kitchenLightButtonIndex);
  remoteControl.offButtonWasPushed(kitchenLightButtonIndex);
  remoteControl.undoButtonWasPushed();

  remoteControl.onButtonWasPushed(livingRoomCeilingFanHighButtonIndex);
  remoteControl.offButtonWasPushed(livingRoomCeilingFanHighButtonIndex);
  remoteControl.undoButtonWasPushed();
  remoteControl.onButtonWasPushed(livingRoomCeilingFanLowButtonIndex);
}
```

``` 
###### OUTPUT #################
living Room Light on!
kitchen Light on!
kitchen Light off!
kitchen Light on!
living Room CeilingFan's speed is high
living Room CeilingFan's is off
living Room CeilingFan's speed is high
living Room CeilingFan's speed is low
```
