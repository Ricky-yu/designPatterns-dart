## Bridge Pattern
The bridge pattern is a design pattern used in software engineering that is meant to "decouple an abstraction from its implementation so that the two can vary independently", introduced by the Gang of Four. The bridge uses encapsulation, aggregation, and can use inheritance to separate responsibilities into different classes.

When a class varies often, the features of object-oriented programming become very useful because changes to a program's code can be made easily with minimal prior knowledge about the program. The bridge pattern is useful when both the class and what it does vary often. The class itself can be thought of as the abstraction and what the class can do as the implementation. The bridge pattern can also be thought of as two layers of abstraction.

When there is only one fixed implementation, this pattern is known as the Pimpl idiom in the C++ world.

The bridge pattern is often confused with the adapter pattern, and is often implemented using the object adapter pattern.

Variant: The implementation can be decoupled even more by deferring the presence of the implementation to the point where the abstraction is utilized.

[Wikipedia: Bridge Pattern](https://en.wikipedia.org/wiki/Bridge_pattern)

[YouTube: Bridge Pattern](https://www.youtube.com/watch?v=F1YQ7YRjttI&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=11&ab_channel=ChristopherOkhravi)

``` dart
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
```

```
########OUTPUT#######
------TVDevice----
Volume at: 1
Channel Down
Channel Up
TV was Muted
------TVDevice2----
Volume at: 1
Channel Down
Channel Up
TV was Paused
------DVDDevice----
Volume at: 1
DVD Skips to Chapter
DVD Skips to Next Chapter
DVD is Playing: false
```
