part of 'machine_bloc.dart';

abstract class MachineState {}

class MachineInitial extends MachineState {}

class MachinesLoadedState extends MachineState {
  final List<Machine> machines;
  final List<Product> products;
  MachinesLoadedState({
    required this.machines,
    required this.products,
  });
}
