// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../widgets/custom_round_textbox.dart';
import '../widgets/custom_app_bar.dart';
import '../screens/search_screen.dart';
import '../widgets/category_item.dart';
import '../widgets/news_item.dart';
import '../utils/data.dart';

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
      appBar: const CustomAppBar(),
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
                        hint: "جستجو",
                        isReadOnly: true,
                        prefix: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
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
                      padding: const EdgeInsets.only(right: 10),
                      child: CategoryItem(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
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
