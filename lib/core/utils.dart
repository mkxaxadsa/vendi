import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/machine.dart';
import 'models/product.dart';

bool onboard = true;
int earned = 0;

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('onboard');
  onboard = prefs.getBool('onboard') ?? true;
}

Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboard', false);
}

List<Machine> machinesList = [];
List<Product> productsList = [];

Future<List<Machine>> getModels() async {
  final box = await Hive.openBox('machinesbox');
  List data = box.get('machinesList') ?? [];
  machinesList = data.cast<Machine>();
  log(machinesList.length.toString());
  productsList = getProducts();
  getTotalProfit();
  return machinesList;
}

Future<List<Machine>> updateModels() async {
  final box = await Hive.openBox('machinesbox');
  box.put('machinesList', machinesList);
  machinesList = await box.get('machinesList');
  productsList = getProducts();
  getTotalProfit();
  return machinesList;
}

int getCurrentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

List<Product> getProducts() {
  List<Product> products = [];
  for (Machine machine in machinesList) {
    for (Product product in machine.products) {
      products.add(product);
    }
  }
  return products;
}

String getProductName(Product product) {
  for (Machine machine in machinesList) {
    if (product.machine == machine.id) {
      return machine.name;
    }
  }
  return '';
}

String getProductType(Product product) {
  for (Machine machine in machinesList) {
    if (product.machine == machine.id) {
      return machine.type;
    }
  }
  return '';
}

String getReplenishment(Product product) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(product.id * 1000);
  DateTime now = DateTime.now();
  int dif = now.difference(dateTime).inDays;

  if (product.consumption == 'Daily') return '1 day';
  if (product.consumption == 'Weekly') return '${calculateDays(7, dif)} days';
  if (product.consumption == 'Monthly') return '${calculateDays(30, dif)} days';
  if (product.consumption == 'Annual') return '${calculateDays(365, dif)} days';
  return '1 days';
}

int calculateDays(int day, int dif) {
  int total = day - dif;
  if (total <= 0) {
    return 0;
  } else {
    return total;
  }
}

void getTotalProfit() {
  earned = 0;
  DateTime now = DateTime.now();
  DateTime startOfMonth = DateTime(now.year, now.month, 1);
  List<Product> currentMonthModels = productsList.where((model) {
    DateTime modelDate = DateTime.fromMillisecondsSinceEpoch(model.id * 1000);
    return modelDate.isAfter(startOfMonth) ||
        modelDate.isAtSameMomentAs(startOfMonth);
  }).toList();
  for (Product product in currentMonthModels) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(product.id * 1000);
    DateTime now = DateTime.now();
    int dif = now.difference(dateTime).inDays;
    earned = earned + (dif * product.price);
  }
}
