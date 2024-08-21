import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/machine.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../bloc/machine_bloc.dart';
import '../widgets/machine_products_card.dart';

class EditMachinePage extends StatefulWidget {
  const EditMachinePage({super.key, required this.machine});

  final Machine machine;

  @override
  State<EditMachinePage> createState() => _EditMachinePageState();
}

class _EditMachinePageState extends State<EditMachinePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  void onEdit() {
    context.read<MachineBloc>().add(
          EditMachineEvent(
            machine: Machine(
              id: widget.machine.id,
              name: controller1.text,
              location: controller2.text,
              type: widget.machine.type,
              products: widget.machine.products,
            ),
          ),
        );
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.machine.name;
    controller2.text = widget.machine.location;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CustomAppbar('Machine', onEdit: onEdit),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 40),
                TxtField(
                  controller: controller1,
                  hintText: 'Name',
                  onChanged: () {},
                ),
                const SizedBox(height: 24),
                TxtField(
                  controller: controller2,
                  hintText: 'Location',
                  onChanged: () {},
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 28,
                  child: Row(
                    children: [
                      const SizedBox(width: 28),
                      const Spacer(),
                      const Text(
                        'Products',
                        style: TextStyle(
                          color: AppColors.main,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SFB',
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        onPressed: () {
                          context.push('/product-add', extra: widget.machine);
                        },
                        padding: EdgeInsets.zero,
                        minSize: 28,
                        child: SvgPicture.asset(
                          'assets/add.svg',
                          color: AppColors.main,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...List.generate(
                  widget.machine.products.length,
                  (index) {
                    return MachineProductsCard(
                      product: widget.machine.products[index],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
