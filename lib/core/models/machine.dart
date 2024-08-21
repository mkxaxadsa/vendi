import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Machine {
  @HiveField(0)
  final int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String location;
  @HiveField(3)
  String type;
  @HiveField(4)
  List products;

  Machine({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.products,
  });
}

class MachineAdapter extends TypeAdapter<Machine> {
  @override
  final typeId = 0;

  @override
  Machine read(BinaryReader reader) {
    return Machine(
      id: reader.read(),
      name: reader.read(),
      location: reader.read(),
      type: reader.read(),
      products: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Machine obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.location);
    writer.write(obj.type);
    writer.write(obj.products);
  }
}
