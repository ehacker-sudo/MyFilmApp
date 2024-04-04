import 'package:redux/redux.dart';

import 'search_actions.dart';
import 'search_state.dart';

/// Reducer
final searchReducer = combineReducers<SearchState>([
  // Tìm kiếm phim hoặc diễn viên
  TypedReducer<SearchState, SearchInitialAction>(_onInitial),
  TypedReducer<SearchState, SearchLoadingAction>(_onLoad),
  TypedReducer<SearchState, SearchErrorAction>(_onError),
  TypedReducer<SearchState, SearchResultAction>(_onResult),
  // Lấy dữ liệu
]);

// Tìm kiếm phim hoặc diễn viên
SearchState _onInitial(SearchState state, SearchInitialAction action) =>
    SearchInitial();

SearchState _onLoad(SearchState state, SearchLoadingAction action) =>
    SearchLoading();

SearchState _onError(SearchState state, SearchErrorAction action) =>
    SearchError();

SearchState _onResult(SearchState state, SearchResultAction action) =>
    action.result.items.isEmpty
        ? SearchEmpty()
        : SearchPopulated(action.result);

// // Lấy dữ liệu
// SearchState _onFilmLoad(SearchState state, FilmLoadingAction action) =>
//     SearchLoading();

// SearchState _onFilmError(SearchState state, FilmErrorAction action) =>
//     SearchError();

// SearchState _onFilmResult(SearchState state, SearchResultAction action) =>
//     action.result.items.isEmpty
//         ? SearchEmpty()
//         : SearchPopulated(action.result);
