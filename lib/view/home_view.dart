import 'package:cats_api_test/bloc/bloc.dart';
import 'package:cats_api_test/bloc/event/cat_object_event.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_error.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_loaded.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_state.dart';
import 'package:cats_api_test/bloc/state/cat_bloc_uninitialized.dart';
import 'package:cats_api_test/util/static_text.dart';
import 'package:cats_api_test/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  CatObjectBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = BlocProvider.of<CatObjectBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          StaticText.homeViewTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<CatObjectBloc, CatObjectState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is CatObjectUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CatObjectError) {
            return Center(
              child: Text(
                StaticText.errorText,
              ),
            );
          }
          if (state is CatObjectLoaded) {
            print("state.cats.length => ${state.cats.length}");
            if (state.cats.isEmpty) {
              return Center(
                child: Text(
                  StaticText.noKitties,
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.cats.length
                    ? Container(
                        height: 80,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : MainCard(
                        cat: state.cats[index],
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.cats.length
                  : state.cats.length + 1,
              controller: _scrollController,
              padding: EdgeInsets.all(0.0),
              shrinkWrap: true,
            );
          }
        },
      ),
    );
  }
}
