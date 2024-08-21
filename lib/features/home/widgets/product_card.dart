import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/product.dart';
import '../../../core/utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

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
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 72,
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
                  const SizedBox(height: 9),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        getProductName(product),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.main,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFR',
                        ),
                      ),
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
