import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/machine.dart';
import '../../../core/models/product.dart';

class MachineCard extends StatelessWidget {
  const MachineCard({super.key, required this.machine});

  final Machine machine;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.44),
            blurRadius: 4,
          ),
        ],
      ),
      child: CupertinoButton(
        onPressed: () {
          context.push('/edit', extra: machine);
        },
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            machine.type,
                            style: const TextStyle(
                              color: AppColors.main,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'SFL',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    machine.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFB',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    machine.location,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'SFL',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 72,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'SFL',
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (machine.products.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              (machine.products[0] as Product).name,
                              style: const TextStyle(
                                color: Color(0xffA68120),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'SFL',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
