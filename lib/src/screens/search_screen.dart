import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/news_detail/news_detail_bloc.dart';
import '../blocs/news_detail/news_detail_event.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_round_textbox.dart';
import '../widgets/news_item.dart';
import '../widgets/loader.dart';
import '../utils/translation_util.dart';
import './news_details_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomRoundTextBox(
                    hint: getTranslated(context, 'search'),
                    isReadOnly: false,
                    isAutoFocus: true,
                    controller: _searchController,
                    onChanged: (val) {
                      if (val!.isNotEmpty) {
                        context.read<SearchBloc>()
                          ..add(SearchTermChanged(text: val.trim()));
                      }
                    },
                    onSubmitted: (val) {
                      if (val!.isNotEmpty) {
                        context.read<SearchBloc>()
                          ..add(SearchTermChanged(text: val.trim()));
                      }
                    },
                    prefix: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffix: GestureDetector(
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey,
                        size: 22,
                      ),
                      onTap: () {
                        _searchController.clear();
                        context.read<SearchBloc>()..add(ClearButtonPressed());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadIsEmpty) {
                  return Text('News not found');
                }
                if (state is SearchIsLoading) {
                  return Loader();
                }
                if (state is SearchLoadSuccess) {
                  if (state.news.length == 0) {
                    return Text('News not found');
                  }
                  // final newsState = context.select((NewsBloc bloc) => bloc);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.news.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsItem(
                        onBookmarkTap: () {
                          // context
                          //     .read<NewsBloc>()
                          //     .add(NewsBookmarked(state.news[index].id));
                        },
                        onTap: () {
                          context
                              .read<NewsDetailBloc>()
                              .add(NewsDetailFetched(state.news[index].id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                newsId: state.news[index].id,
                              ),
                            ),
                          );
                        },
                        data: state.news[index],
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
