enum EnginePosition {
  front('Front'),
  mid('Mid');

  const EnginePosition(this.name);
  final String name;
}

abstract class FloorPlan {
  late int seats;
  late EnginePosition enginePosition;
  FloorPlan(this.seats, this.enginePosition);
}

class ShortFloorplan extends FloorPlan {
  ShortFloorplan({seats = 2, enginePosition = EnginePosition.mid})
      : super(seats, enginePosition);
}

class StandardFloorplan extends FloorPlan {
  StandardFloorplan({seats = 4, enginePosition = EnginePosition.front})
      : super(seats, enginePosition);
}

class LongFloorplan extends FloorPlan {
  LongFloorplan({seats = 8, enginePosition = EnginePosition.front})
      : super(seats, enginePosition);
}

enum SuspensionType {
  standard('Standard'),
  sports('Firm'),
  soft('Soft');

  const SuspensionType(this.name);
  final String name;
}

abstract class Suspension {
  late SuspensionType suspensionType;
  Suspension(this.suspensionType);
}

class RoadSuspension extends Suspension {
  RoadSuspension({suspensionType = SuspensionType.standard})
      : super(suspensionType);
}

class OffRoadSuspension extends Suspension {
  OffRoadSuspension({suspensionType = SuspensionType.soft})
      : super(suspensionType);
}

class RaceSuspension extends Suspension {
  RaceSuspension({suspensionType = SuspensionType.sports})
      : super(suspensionType);
}

enum Cars {
  compact('VM Golf'),
  sports('Porsche Boxter'),
  suv('Cadillac Escalade'),
  sportsSuv('Porsche SUV');

  const Cars(this.name);
  final String name;
}

class Car {
  final Cars carType;
  final FloorPlan floor;
  final Suspension suspension;
  Car({required this.carType, required this.floor, required this.suspension});

  void printDetails() {
    print("Car type: ${carType.name}");
    print("Seats: ${floor.seats}");
    print("Engine: ${floor.enginePosition}");
    print("Suspension: ${suspension.suspensionType}");
  }
}

abstract class CarFactory {
  FloorPlan createFloorPlan();
  Suspension createSuspension();
  static CarFactory getFactory(Cars car) {
    switch (car) {
      case Cars.compact:
        return CompactCarFactory();
      case Cars.sports:
        return SportsCarFactory();
      case Cars.suv:
        return SUVCarFactory();
      case Cars.sportsSuv:
        return SportsSUVFactory();
    }
  }
}

class CompactCarFactory implements CarFactory {
  FloorPlan createFloorPlan() {
    return StandardFloorplan();
  }

  Suspension createSuspension() {
    return RoadSuspension();
  }
}

class SportsCarFactory implements CarFactory {
  FloorPlan createFloorPlan() {
    return ShortFloorplan();
  }

  Suspension createSuspension() {
    return RaceSuspension();
  }
}

class SUVCarFactory implements CarFactory {
  FloorPlan createFloorPlan() {
    return LongFloorplan();
  }

  Suspension createSuspension() {
    return OffRoadSuspension();
  }
}

class SportsSUVFactory implements CarFactory {
  FloorPlan createFloorPlan() {
    return LongFloorplan();
  }

  Suspension createSuspension() {
    return RaceSuspension();
  }
}

void main() {
  CarFactory carFactory1 = CarFactory.getFactory(Cars.sports);
  Car car1 = Car(
      carType: Cars.sports,
      floor: carFactory1.createFloorPlan(),
      suspension: carFactory1.createSuspension());
  car1.printDetails();

  CarFactory carFactory2 = CarFactory.getFactory(Cars.sportsSuv);
  Car car2 = Car(
      carType: Cars.sportsSuv,
      floor: carFactory2.createFloorPlan(),
      suspension: carFactory2.createSuspension());
  car2.printDetails();
}
