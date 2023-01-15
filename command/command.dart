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
