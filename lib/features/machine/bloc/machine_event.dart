part of 'machine_bloc.dart';

abstract class MachineEvent {}

class GetMachinesEvent extends MachineEvent {}

class AddMachineEvent extends MachineEvent {
  final Machine machine;
  AddMachineEvent({required this.machine});
}

class EditMachineEvent extends MachineEvent {
  final Machine machine;
  EditMachineEvent({required this.machine});
}

class DeleteMachineEvent extends MachineEvent {
  final int id;
  DeleteMachineEvent({required this.id});
}

class AddProductEvent extends MachineEvent {
  final Machine machine;
  final Product product;
  AddProductEvent({
    required this.machine,
    required this.product,
  });
}

class EditProductEvent extends MachineEvent {
  final Product product;
  final bool replenish;
  EditProductEvent({
    required this.product,
    required this.replenish,
  });
}

class DeleteProductEvent extends MachineEvent {
  final Product product;
  DeleteProductEvent({required this.product});
}
