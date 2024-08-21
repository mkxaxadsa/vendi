import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/news.dart';

class NewsReadPage extends StatelessWidget {
  const NewsReadPage({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _Image(news: news),
          const _Appbar(),
          const _BackButton(),
          Container(
            margin: const EdgeInsets.only(top: 240),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    children: [
                      const SizedBox(height: 42),
                      _Title(news: news),
                      const SizedBox(height: 20),
                      _Content(news: news),
                      const SizedBox(height: 42),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.grey,
      ),
      child: CachedNetworkImage(
        imageUrl: news.image,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) {
          return const Center(
            child: Text(
              'Error',
              style: TextStyle(
                color: AppColors.main,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  const _Appbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.main,
            AppColors.main,
            const Color(0xff555FB4).withOpacity(0.8),
            const Color(0xff555FB4).withOpacity(0.5),
            const Color(0xff555FB4).withOpacity(0.2),
            const Color(0xff555FB4).withOpacity(0),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4,
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: SizedBox(
        height: 44,
        width: 80,
        child: CupertinoButton(
          onPressed: () {
            context.pop();
          },
          padding: EdgeInsets.zero,
          child: const Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'SFL',
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            news.title,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFB',
            ),
          ),
        ),
        Container(
          height: 20,
          width: 54,
          decoration: BoxDecoration(
            color: AppColors.main,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              news.date,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w300,
                fontFamily: 'SFL',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Text(
      news.content,
      style: const TextStyle(
        color: Color(0xff787878),
        fontSize: 22,
        fontWeight: FontWeight.w500,
        fontFamily: 'SFM',
      ),
    );
  }
}
