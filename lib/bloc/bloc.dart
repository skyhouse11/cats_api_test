import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';

import 'package:cats_api_test/bloc/data_object/cat_object.dart';

import 'package:cats_api_test/bloc/state/cat_bloc_error.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_loaded.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_uninitialized.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_state.dart';

import 'package:cats_api_test/bloc/event/cat_object_event.dart';

import 'package:cats_api_test/service/api_service.dart';

class CatObjectBloc extends Bloc<CatObjectEvent, CatObjectState> {
  final ApiService apiService;

  CatObjectBloc({this.apiService});

  @override
  CatObjectState get initialState => CatObjectUninitialized();

  @override
  Stream<Transition<CatObjectEvent, CatObjectState>> transformEvents(
    Stream<CatObjectEvent> events,
    TransitionFunction<CatObjectEvent, CatObjectState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  bool _hasReachedMax(CatObjectState state) =>
      state is CatObjectLoaded && state.hasReachedMax;

  int _currentPage = 1;

  @override
  Stream<CatObjectState> mapEventToState(CatObjectEvent event) async* {
    final currentState = state;

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is CatObjectUninitialized) {
          final List<Cat> cats = await _fetchPosts(page: _currentPage);
          yield CatObjectLoaded(cats: cats, hasReachedMax: false);
          return;
        } else if (currentState is CatObjectLoaded) {
          final List<Cat> cats = await _fetchPosts(page: ++_currentPage);
          yield cats.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : CatObjectLoaded(
                  cats: currentState.cats + cats,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield CatObjectError();
      }
    }
  }

  Future<List<Cat>> _fetchPosts({int page}) async {
    final Response response =
        await ApiService.instance.receivePageOfCats(page: page);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<Map<String, dynamic>>;

      return data.map((Map<String, dynamic> json) {
        return Cat.fromJson(json);
      }).toList();
    } else {
      throw Exception('Error -> Failed to fetch cats');
    }
  }
}
