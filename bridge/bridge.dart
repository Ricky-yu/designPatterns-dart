abstract class EntertainmentDevice {
  late int deviceState;
  late int maxSetting;
  int volumeLevel = 0;

  void buttonFivePressed();
  void buttonSixPressed();

  void deviceFeedback() {
    if (deviceState > maxSetting || deviceState < 0) deviceState = 0;
    print("On Channel $deviceState");
  }

  void volumePlusButtonPressed() {
    volumeLevel++;
    print("Volume at: $volumeLevel");
  }

  void volumeMinusButtonPressed() {
    volumeLevel--;
    print("Volume at: $volumeLevel");
  }
}

class TVDevice extends EntertainmentDevice {
  TVDevice(int newDeviceState, int newMaxSetting) {
    deviceState = newDeviceState;
    maxSetting = newMaxSetting;
  }

  @override
  void buttonFivePressed() {
    deviceState--;
    print("Channel Down");
  }

  @override
  void buttonSixPressed() {
    deviceState++;
    print("Channel Up");
  }
}

class DVDDevice extends EntertainmentDevice {
  DVDDevice(int newDeviceState, int newMaxSetting) {
    deviceState = newDeviceState;
    maxSetting = newMaxSetting;
  }

  @override
  void buttonFivePressed() {
    deviceState--;
    print("DVD Skips to Chapter");
  }

  @override
  void buttonSixPressed() {
    deviceState++;
    print("DVD Skips to Next Chapter");
  }
}

abstract class RemoteButton {
  late EntertainmentDevice _theDevice;
  RemoteButton(this._theDevice);

  void buttonFivePressed() {
    _theDevice.buttonFivePressed();
  }

  void buttonSixPressed() {
    _theDevice.buttonSixPressed();
  }

  void buttonNinPressed();
}

class TVRemoteMute extends RemoteButton {
  TVRemoteMute(newDevice) : super(newDevice);

  @override
  void buttonNinPressed() {
    print("TV was Muted");
  }
}

class TVRemotePause extends RemoteButton {
  TVRemotePause(newDevice) : super(newDevice);

  @override
  void buttonNinPressed() {
    print("TV was Paused");
  }
}

class DVDRemote extends RemoteButton {
  bool _play = true;
  DVDRemote(newDevice) : super(newDevice);

  @override
  void buttonNinPressed() {
    _play = !_play;
    print("DVD is Playing: $_play");
  }
}

void main() {
  print("------TVDevice----");
  TVDevice tvDevice = TVDevice(1, 200);
  tvDevice.volumePlusButtonPressed();
  RemoteButton theTV = TVRemoteMute(TVDevice(1, 200));

  theTV.buttonFivePressed();
  theTV.buttonSixPressed();
  theTV.buttonNinPressed();

  print("------TVDevice2----");
  TVDevice tvDevice2 = TVDevice(1, 100);
  tvDevice2.volumePlusButtonPressed();
  RemoteButton theTV2 = TVRemotePause(tvDevice2);

  theTV2.buttonFivePressed();
  theTV2.buttonSixPressed();
  theTV2.buttonNinPressed();

  print("------DVDDevice----");
  DVDDevice dvdDevice = DVDDevice(1, 14);
  dvdDevice.volumePlusButtonPressed();
  RemoteButton theDVD = DVDRemote(dvdDevice);
  theDVD.buttonFivePressed();
  theDVD.buttonSixPressed();
  theDVD.buttonNinPressed();
}
