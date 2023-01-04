// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/custom_round_textbox.dart';
import '../widgets/category_item.dart';
import '../widgets/news_item.dart';
import '../widgets/icon_box.dart';
import '../utils/data.dart';
import '../theme/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconBox(
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    color: darker,
                    width: 28,
                    height: 28,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Amir mohammad',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            IconBox(
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                color: darker,
                width: 28,
                height: 28,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomRoundTextBox(
                        hint: "Search",
                        prefix: const Icon(Icons.search, color: Colors.grey),
                        onTap: () {
                          // ignore: avoid_print
                          print('Hello searching...');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CategoryItem(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 10),
                        data: categories[index],
                        isSelected: index == _selectedCategoryIndex,
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: news.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsItem(
                    data: news[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
