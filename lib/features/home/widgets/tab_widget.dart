import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: const Border(
                      bottom: BorderSide(
                        color: Color(0xffCECECE),
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: const Border(
                      bottom: BorderSide(
                        color: Color(0xffCECECE),
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          TabBar(
            controller: tabController,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: AppColors.main,
                width: 4,
              ),
            ),
            labelPadding: const EdgeInsets.only(bottom: 14),
            labelStyle: const TextStyle(
              color: Color(0xff022150),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'SFM',
            ),
            unselectedLabelStyle: const TextStyle(
              color: Color(0xff8090A7),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'SFM',
            ),
            tabs: const [
              Tab(text: 'Machines'),
              Tab(text: 'Products'),
            ],
          ),
        ],
      ),
    );
  }
}
