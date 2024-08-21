import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vending_test/core/config/app_colors.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.title,
    this.yesText = 'YES',
    this.noText = 'CANCEL',
    this.height = 150,
    this.children = const [],
    required this.onYes,
  });

  final String title;
  final String yesText;
  final String noText;
  final double height;
  final List<Widget> children;
  final void Function() onYes;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.main,
      child: SizedBox(
        height: height,
        width: MediaQuery.of(context).size.width > 300 ? 300 : null,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            ...children,
            const Spacer(),
            Row(
              children: [
                const SizedBox(width: 20),
                _Button(
                  title: noText,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                _Button(
                  title: yesText,
                  onPressed: () {
                    Navigator.pop(context);
                    onYes();
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF',
            ),
          ),
        ],
      ),
    );
  }
}
