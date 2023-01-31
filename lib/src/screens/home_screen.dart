// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/blocs/auth/auth_bloc.dart';

import '../widgets/custom_round_textbox.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/category_item.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_event.dart';
import '../blocs/category/category_state.dart';
import '../models/category.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import './sign_up_screen.dart';
import './search_screen.dart';
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
        buildWhen: (previous, current) => current is Authenticated,
        builder: (context, authState) {
          if (authState is Authenticated) {
            context
                .read<CategoryBloc>()
                .add(CategoryFetched(authState.user.accessToken));
          }
          return Container(
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
                    buildWhen: (previous, current) =>
                        current is CategorySuccess,
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Container(
                          child: const Center(
                            child: Text('Category is loading..'),
                          ),
                        );
                      }
                      if (state is CategoryFailure) {
                        return Container(
                          child: const Center(
                            child: Text('Failed to load category'),
                          ),
                        );
                      }
                      if (state is CategorySuccess) {
                        final categoryList = state.categories;
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: news.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsItem(
                        data: news[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailsScreen(data: news[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
