import 'package:flutter/material.dart';

import '../../../core/models/news.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar('News'),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 7,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              shrinkWrap: false,
              childAspectRatio: 1.4,
              children: [
                ...List.generate(
                  newsList.length,
                  (index) {
                    return NewsCard(news: newsList[index]);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
