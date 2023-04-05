## Adapter Pattern
An adapter allows two incompatible interfaces to work together. This is the real-world definition for an adapter. Interfaces may be incompatible, but the inner functionality should suit the need. The adapter design pattern allows otherwise incompatible classes to work together by converting the interface of one class into an interface expected by the clients.

[Wikipedia: Adapter Pattern](https://en.wikipedia.org/wiki/Adapter_pattern)

[YouTube: Adapter Pattern](https://www.youtube.com/watch?v=2PKQtcJjYvc&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc&index=8&ab_channel=ChristopherOkhravi)

``` dart
abstract class AndroidPhone {
  void charge();
}

abstract class IPhone {
  void charge();
}

class OnePlus5 implements AndroidPhone {
  void charge() {
    print("Charging OnePlus 5");
  }
}

class AndroidPhoneCharger {
  void charge(AndroidPhone androidPhone) {
    androidPhone.charge();
  }
}

class IPhoneX implements IPhone {
  void charge() {
    print("Charging IPhone X");
  }
}

class IPhoneCharger {
  void charge(IPhone iPhone) {
    iPhone.charge();
  }
}

class AndroidToIPhoneAdapter implements IPhone {
  final AndroidPhone androidPhone;

  AndroidToIPhoneAdapter(this.androidPhone);

  void charge() {
    androidPhone.charge();
  }
}

void main() {
  final AndroidPhoneCharger androidPhoneCharger = AndroidPhoneCharger();
  final AndroidPhone androidPhone = OnePlus5();
  androidPhoneCharger.charge(androidPhone);

  final IPhoneCharger iPhoneCharger = IPhoneCharger();
  final IPhone iPhone = IPhoneX();
  iPhoneCharger.charge(iPhone);

  final AndroidToIPhoneAdapter adapter = AndroidToIPhoneAdapter(androidPhone);
  iPhoneCharger.charge(adapter);
}
```

```
######OUTPUT######
Charging OnePlus 5
Charging IPhone X
Charging OnePlus 5
```
