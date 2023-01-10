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
