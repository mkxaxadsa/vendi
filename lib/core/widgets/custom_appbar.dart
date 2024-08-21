import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../config/app_colors.dart';
import 'buttons/arrow_back_button.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
    this.title, {
    super.key,
    this.home = false,
    this.onEdit,
    this.onBack,
  });

  final String title;
  final bool home;
  final void Function()? onEdit;
  final void Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          const SizedBox(width: 4),
          if (home)
            CupertinoButton(
              onPressed: () {
                context.push('/settings');
              },
              padding: EdgeInsets.zero,
              minSize: 44,
              child: SvgPicture.asset('assets/settings.svg'),
            )
          else
            ArrowBackButton(
              onPressed: onBack ??
                  () {
                    Navigator.pop(context);
                  },
            ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFB',
            ),
          ),
          const Spacer(),
          if (onEdit != null) ...[
            SizedBox(
              width: 68,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    onPressed: onEdit,
                    padding: EdgeInsets.zero,
                    minSize: 44,
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.main,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'SFL',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ] else if (home)
            CupertinoButton(
              onPressed: () {
                context.push('/news');
              },
              padding: EdgeInsets.zero,
              minSize: 44,
              child: const Text(
                'News',
                style: TextStyle(
                  color: AppColors.main,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFM',
                ),
              ),
            )
          else
            const SizedBox(width: 76),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
