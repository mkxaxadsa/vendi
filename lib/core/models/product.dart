import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int price;
  @HiveField(3)
  int consumptionPrice;
  @HiveField(4)
  String consumption;
  @HiveField(5)
  final int machine;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.consumptionPrice,
    required this.consumption,
    required this.machine,
  });
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 1;

  @override
  Product read(BinaryReader reader) {
    return Product(
      id: reader.read(),
      name: reader.read(),
      price: reader.read(),
      consumptionPrice: reader.read(),
      consumption: reader.read(),
      machine: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.price);
    writer.write(obj.consumptionPrice);
    writer.write(obj.consumption);
    writer.write(obj.machine);
  }
}
