import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/primary_button.dart';

class HomeAddButton extends StatelessWidget {
  const HomeAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 48,
        left: 20,
        right: 20,
      ),
      child: PrimaryButton(
        title: 'Add machine',
        asset: 'add',
        onPressed: () {
          context.push('/add');
        },
      ),
    );
  }
}
