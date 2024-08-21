import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/machine.dart';
import '../../../core/models/product.dart';
import '../../../core/utils.dart';

part 'machine_event.dart';
part 'machine_state.dart';

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  List<Machine> _machines = [];

  MachineBloc() : super(MachineInitial()) {
    on<GetMachinesEvent>((event, emit) async {
      if (machinesList.isEmpty) {
        _machines = await getModels();
        emit(MachinesLoadedState(
          machines: _machines,
          products: productsList,
        ));
      } else {
        emit(MachinesLoadedState(
          machines: _machines,
          products: productsList,
        ));
      }
    });

    on<AddMachineEvent>((event, emit) async {
      machinesList.add(event.machine);
      _machines = await updateModels();
      emit(MachinesLoadedState(
        machines: _machines,
        products: productsList,
      ));
    });

    on<EditMachineEvent>((event, emit) async {
      for (Machine machine in machinesList) {
        if (machine.id == event.machine.id) {
          machine.name = event.machine.name;
          machine.location = event.machine.location;
          machine.type = event.machine.type;
          machine.products = event.machine.products;
        }
      }
      _machines = await updateModels();
      emit(MachinesLoadedState(
        machines: _machines,
        products: productsList,
      ));
    });

    on<DeleteMachineEvent>((event, emit) async {
      machinesList.removeWhere((element) => element.id == event.id);
      _machines = await updateModels();
      emit(MachinesLoadedState(
        machines: _machines,
        products: productsList,
      ));
    });

    on<AddProductEvent>((event, emit) async {
      event.machine.products.add(event.product);
      _machines = await updateModels();
      emit(MachinesLoadedState(
        machines: _machines,
        products: productsList,
      ));
    });

    on<EditProductEvent>((event, emit) async {
      for (Machine machine in machinesList) {
        for (Product product in machine.products) {
          if (product.id == event.product.id) {
            if (event.replenish) product.id = getCurrentTimestamp();
            product.name = event.product.name;
            product.price = event.product.price;
            product.consumptionPrice = event.product.consumptionPrice;
            product.consumption = event.product.consumption;
          }
        }
      }
      _machines = await updateModels();
      emit(MachinesLoadedState(
        machines: _machines,
        products: productsList,
      ));
    });

    on<DeleteProductEvent>((event, emit) async {
      for (Machine machine in machinesList) {
        for (Product product in machine.products) {
          if (product.id == event.product.id) {
            machine.products.remove(product);
            _machines = await updateModels();
            emit(MachinesLoadedState(
              machines: _machines,
              products: productsList,
            ));
            return;
          }
        }
      }
    });
  }
}
