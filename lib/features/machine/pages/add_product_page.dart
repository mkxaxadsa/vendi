import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vending_test/core/utils.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/machine.dart';
import '../../../core/models/product.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../bloc/machine_bloc.dart';
import '../widgets/consumption_times.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key, required this.machine});

  final Machine machine;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();

  String consumption = '';
  bool active = false;

  void checkActive() {
    setState(() {
      if (controller3.text.isEmpty) {
        active = false;
      } else if (controller4.text.isEmpty) {
        active = false;
      } else if (controller5.text.isEmpty) {
        active = false;
      } else if (consumption.isEmpty) {
        active = false;
      } else {
        active = true;
      }
    });
  }

  void onConsumptionSelect(String value) {
    consumption = value;
    checkActive();
  }

  void onAdd() {
    context.read<MachineBloc>().add(
          AddProductEvent(
            machine: widget.machine,
            product: Product(
              id: getCurrentTimestamp(),
              name: controller3.text,
              price: int.tryParse(controller4.text) ?? 0,
              consumptionPrice: int.tryParse(controller5.text) ?? 0,
              consumption: consumption,
              machine: widget.machine.id,
            ),
          ),
        );
    context.pop();
  }

  @override
  void dispose() {
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
          const CustomAppbar('Add product'),
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
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
                    consumption: consumption,
                    onTap: onConsumptionSelect,
                  ),
                  const Spacer(),
                  PrimaryButton(
                    title: 'Done',
                    active: active,
                    onPressed: onAdd,
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
