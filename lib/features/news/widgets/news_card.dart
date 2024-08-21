import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/news.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      padding: const EdgeInsets.all(8),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    news.date,
                    style: const TextStyle(
                      color: AppColors.main,
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'SFL',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Text(
                news.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SFB',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                news.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'SFL',
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CupertinoButton(
              onPressed: () {
                context.push('/news-read', extra: news);
              },
              padding: EdgeInsets.zero,
              minSize: 20,
              child: Container(
                height: 20,
                width: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'View all',
                    style: TextStyle(
                      color: AppColors.main,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SFM',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
