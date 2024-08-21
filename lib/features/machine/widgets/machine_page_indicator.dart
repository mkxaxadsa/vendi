import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class MachinePageIndicator extends StatelessWidget {
  const MachinePageIndicator({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: index == 0 ? AppColors.main : AppColors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: index == 1 ? AppColors.main : AppColors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: index == 2 ? AppColors.main : AppColors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }
}
