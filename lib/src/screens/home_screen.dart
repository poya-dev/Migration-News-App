import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/blocs/auth/auth_bloc.dart';

import '../widgets/custom_round_textbox.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/category_item.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_state.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/news/news_event.dart';
import '../blocs/news/news_state.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import './sign_up_screen.dart';
import './search_screen.dart';

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
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is UnAuthenticated,
        listener: (context, authState) {
          if (authState is UnAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          }
        },
        builder: (context, authState) {
          return Container(
            padding: const EdgeInsets.all(6),
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
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, newsState) {
                      if (newsState is CategoryLoading) {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          child: const Center(
                            child: Text('Category is loading..'),
                          ),
                        );
                      }
                      if (newsState is CategoryFailure) {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          child: const Center(
                            child: Text('Failed to load category'),
                          ),
                        );
                      }
                      if (newsState is CategorySuccess) {
                        final categoryList = newsState.categories;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              categoryList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CategoryItem(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  data: categoryList[index],
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
                        );
                      }
                      return Container();
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state.status == Status.initial) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            child: const Center(
                              child: Text('News is loading..'),
                            ),
                          );
                        }
                        if (state.status == Status.failure) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            child: const Center(
                              child: Text('Failed to load News'),
                            ),
                          );
                        }
                        if (state.status == Status.success) {
                          final news = state.news;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: news.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsItem(
                                data: news[index],
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailsScreen(
                                      data: news[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
