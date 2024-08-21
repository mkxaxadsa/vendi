import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No data',
        style: TextStyle(
          color: AppColors.main,
        ),
      ),
    );
  }
}
