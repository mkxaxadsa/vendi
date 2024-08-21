import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_colors.dart';
import '../../core/utils.dart';
import '../../core/widgets/buttons/primary_button.dart';
import '../../core/widgets/custom_scaffold.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset('assets/onboard.svg'),
            const SizedBox(height: 32),
            const Text(
              'Welcome to Earnings Engine\nyour assistant in increasing the\nprofitability of vending machines!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFB',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Track, analyze, and optimize your business with our\nconvenient app',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.main,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFM',
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                title: 'Start',
                asset: 'start',
                onPressed: () async {
                  await saveData().then((value) {
                    context.go('/home');
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              minSize: 20,
              child: const Text(
                'Terms of Use / Privacy Policy',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SFR',
                ),
              ),
            ),
            const SizedBox(height: 53),
          ],
        ),
      ),
    );
  }
}
