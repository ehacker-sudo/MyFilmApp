import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/search/search/view/search_empty_view.dart';
import 'package:myfilmapp/screens/search/search/view/search_error_view.dart';
import 'package:myfilmapp/screens/search/search/view/search_initial_view.dart';
import 'package:myfilmapp/screens/search/search/view/search_loading_view.dart';
import 'package:myfilmapp/screens/search/search/view/search_result_view.dart';
import 'package:myfilmapp/widgets/navbar.dart';

import 'search_actions.dart';
import 'search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String searchText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchText = "";
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SearchState, _SearchScreenViewModel>(
      converter: (store) {
        return _SearchScreenViewModel(
          state: store.state,
          onTextChanged: (term) => store.dispatch(SearchAction(term)),
        );
      },
      builder: (BuildContext context, _SearchScreenViewModel vm) {
        return Scaffold(
          backgroundColor: MyFilmAppColors.body,
          appBar: Navbar(
            backButton: true,
            searchBar: true,
            onBack: () {
              setState(() {
                vm.onTextChanged("");
              });
            },
            onSubmit: (text) {
              setState(() {
                searchText = text;
              });
            },
            onChanged: (text) {
              setState(() {
                searchText = text;
                vm.onTextChanged(text);
              });
            },
          ),
          body: Flex(direction: Axis.vertical, children: <Widget>[
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildVisible(vm.state),
              ),
            )
          ]),
        );
      },
    );
  }

  Widget _buildVisible(SearchState state) {
    if (state is SearchLoading) {
      return SearchLoadingView();
    } else if (state is SearchEmpty) {
      return SearchEmptyView();
    } else if (state is SearchPopulated) {
      return SearchPopulatedView(state.result);
    } else if (state is SearchInitial) {
      return const SearchInitialView();
    } else if (state is SearchError) {
      return SearchErrorWidget();
    }

    throw ArgumentError('No view for state: $state');
  }
}

class _SearchScreenViewModel {
  final SearchState state;
  final void Function(String term) onTextChanged;

  _SearchScreenViewModel({required this.state, required this.onTextChanged});
}
