import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class ConsumptionTimes extends StatelessWidget {
  const ConsumptionTimes({
    super.key,
    required this.consumption,
    required this.onTap,
  });

  final String consumption;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _TimeCard(
              title: 'Daily',
              active: consumption == 'Daily',
              onTap: onTap,
            ),
            const SizedBox(width: 8),
            _TimeCard(
              title: 'Weekly',
              active: consumption == 'Weekly',
              onTap: onTap,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _TimeCard(
              title: 'Monthly',
              active: consumption == 'Monthly',
              onTap: onTap,
            ),
            const SizedBox(width: 8),
            _TimeCard(
              title: 'Annual',
              active: consumption == 'Annual',
              onTap: onTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _TimeCard extends StatelessWidget {
  const _TimeCard({
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
