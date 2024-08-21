import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/machine.dart';
import '../../../core/models/product.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../bloc/machine_bloc.dart';
import '../widgets/consumption_times.dart';
import '../widgets/machine_page_indicator.dart';
import '../widgets/machine_types.dart';

class AddMachinePage extends StatefulWidget {
  const AddMachinePage({super.key});

  @override
  State<AddMachinePage> createState() => _AddMachinePageState();
}

class _AddMachinePageState extends State<AddMachinePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();

  bool active = false;
  int pageIndex = 0;
  String pageTitle = 'New machine';
  String machineType = '';
  String cunsumption = '';

  void checkActive() {
    setState(() {
      if (pageIndex == 0) {
        if (controller1.text.isEmpty) {
          active = false;
        } else if (controller2.text.isEmpty) {
          active = false;
        } else {
          active = true;
        }
      } else if (pageIndex == 2) {
        if (controller3.text.isEmpty) {
          active = false;
        } else if (controller4.text.isEmpty) {
          active = false;
        } else if (controller5.text.isEmpty) {
          active = false;
        } else if (cunsumption.isEmpty) {
          active = false;
        } else {
          active = true;
        }
      }
    });
  }

  void onTypeSelect(String value) {
    setState(() {
      machineType = value;
      active = true;
    });
  }

  void onConsumptionSelect(String value) {
    cunsumption = value;
    checkActive();
  }

  void changeValues(bool next) {
    if (next) {
      pageIndex++;
      active = false;
    } else {
      if (pageIndex == 2) {
        controller3.clear();
        controller4.clear();
        controller5.clear();
        cunsumption = '';
        machineType = '';
        active = false;
      }
      pageIndex--;
    }
    setState(() {
      if (pageIndex == 1) {
        pageTitle = 'Type machine';
      } else if (pageIndex == 2) {
        pageTitle = 'Product details';
      } else {
        pageTitle = 'New machine';
        machineType = '';
        active = true;
      }
    });
  }

  void onNext() {
    if (pageIndex == 2) {
      context.read<MachineBloc>().add(
            AddMachineEvent(
              machine: Machine(
                id: getCurrentTimestamp(),
                name: controller1.text,
                location: controller2.text,
                type: machineType,
                products: [
                  Product(
                    id: getCurrentTimestamp(),
                    name: controller3.text,
                    price: int.tryParse(controller4.text) ?? 0,
                    consumptionPrice: int.tryParse(controller5.text) ?? 0,
                    consumption: cunsumption,
                    machine: getCurrentTimestamp(),
                  ),
                ],
              ),
            ),
          );
      context.pop();
    } else {
      changeValues(true);
    }
  }

  void onBack() {
    if (pageIndex == 0) {
      context.pop();
    } else {
      changeValues(false);
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CustomAppbar(
            pageTitle,
            onBack: onBack,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (pageIndex == 0) ...[
                    TxtField(
                      controller: controller1,
                      hintText: 'Name',
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 24),
                    TxtField(
                      controller: controller2,
                      hintText: 'Location',
                      onChanged: checkActive,
                    ),
                  ],
                  if (pageIndex == 1)
                    MachineTypes(
                      type: machineType,
                      onTap: onTypeSelect,
                    ),
                  if (pageIndex == 2) ...[
                    TxtField(
                      controller: controller3,
                      hintText: 'Product name',
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 24),
                    TxtField(
                      controller: controller4,
                      hintText: 'Price per thing',
                      number: true,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 24),
                    TxtField(
                      controller: controller5,
                      hintText: 'Consumption of goods for the period',
                      number: true,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Consumption time',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFB',
                      ),
                    ),
                    const SizedBox(height: 30),
                    ConsumptionTimes(
                      consumption: cunsumption,
                      onTap: onConsumptionSelect,
                    ),
                  ],
                  const Spacer(),
                  MachinePageIndicator(index: pageIndex),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    title: pageIndex == 2 ? 'Done' : 'Next',
                    active: active,
                    onPressed: onNext,
                  ),
                  const SizedBox(height: 47),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
