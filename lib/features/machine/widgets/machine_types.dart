import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class MachineTypes extends StatelessWidget {
  const MachineTypes({
    super.key,
    required this.type,
    required this.onTap,
  });

  final String type;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _MachineTypeCard(
              title: 'Drinks',
              active: type == 'Drinks',
              onTap: onTap,
            ),
            const SizedBox(width: 8),
            _MachineTypeCard(
              title: 'Food',
              active: type == 'Food',
              onTap: onTap,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _MachineTypeCard(
              title: 'Media',
              active: type == 'Media',
              onTap: onTap,
            ),
            const SizedBox(width: 8),
            _MachineTypeCard(
              title: 'Merchandise',
              active: type == 'Merchandise',
              onTap: onTap,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _MachineTypeCard(
              title: 'Medicine',
              active: type == 'Medicine',
              onTap: onTap,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

class _MachineTypeCard extends StatelessWidget {
  const _MachineTypeCard({
    required this.title,
    required this.active,
    required this.onTap,
  });

  final String title;
  final bool active;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        onPressed: active
            ? null
            : () {
                onTap(title);
              },
        padding: EdgeInsets.zero,
        child: Container(
          height: 62,
          decoration: BoxDecoration(
            color: active ? AppColors.main : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.main,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : AppColors.main,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFM',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
