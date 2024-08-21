import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 80,
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: const Row(
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: AppColors.main,
            ),
            SizedBox(width: 5),
            Text(
              'Back',
              style: TextStyle(
                color: AppColors.main,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: 'SFL',
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
