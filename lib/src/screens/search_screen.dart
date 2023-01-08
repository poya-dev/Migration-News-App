import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_round_textbox.dart';
import '../widgets/news_item.dart';
import '../utils/data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomRoundTextBox(
                    hint: "جستجو",
                    isReadOnly: false,
                    isAutoFocus: true,
                    controller: _searchController,
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
    );
  }
}
