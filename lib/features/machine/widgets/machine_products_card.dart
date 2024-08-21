import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vending_test/core/utils.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/product.dart';

class MachineProductsCard extends StatelessWidget {
  const MachineProductsCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 143,
      margin: const EdgeInsets.only(bottom: 20),
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
          context.push('/product-edit', extra: product);
        },
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              flex: 2,
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
                            getProductType(product),
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
                    product.name,
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
                    getProductName(product),
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
            Container(
              height: 100,
              width: 1,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 6),
                        Text(
                          'Need to be replenishment',
                          style: TextStyle(
                            color: getReplenishment(product) == '0 days'
                                ? const Color(0xffEB5757)
                                : const Color(0xffA68120),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFR',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          getReplenishment(product),
                          style: TextStyle(
                            color: getReplenishment(product) == '0 days'
                                ? const Color(0xffEB5757)
                                : const Color(0xffA68120),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFR',
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff32C370),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Text(
                          'Price per thing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFR',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${product.price}\$',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFR',
                          ),
                        ),
                        const SizedBox(width: 7),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Text(
                          'Consumption',
                          style: TextStyle(
                            color: Color(0xffA68120),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFR',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${product.consumptionPrice}/${product.consumption}',
                          style: const TextStyle(
                            color: Color(0xffA68120),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFR',
                          ),
                        ),
                        const SizedBox(width: 7),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
