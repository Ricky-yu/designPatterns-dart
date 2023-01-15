class Light {
  String _location;

  Light(this._location);

  void turnOff() => print("$_location Light off!");
  void turnOn() => print("$_location Light on!");
}

class CeilingFan {
  String _location;
  static final int high = 3;
  static final int low = 1;
  static final int off = 0;
  int _speed = off;
  int? _prevSpeed = off;
  CeilingFan(this._location);

  void setHigh() {
    _prevSpeed = getSpeed();
    _speed = high;
    print("$_location CeilingFan's speed is high");
  }

  void setLow() {
    _prevSpeed = getSpeed();
    _speed = low;
    print("$_location CeilingFan's speed is low");
  }

  void setOff() {
    _prevSpeed = getSpeed();
    _speed = off;
    print("$_location CeilingFan's is off");
  }

  int getSpeed() {
    return _speed;
  }

  void undo() {
    if (_prevSpeed == CeilingFan.high) {
      setHigh();
    } else if (_prevSpeed == CeilingFan.low) {
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
