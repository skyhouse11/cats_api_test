import 'package:cats_api_test/bloc/state/cat_bloc_state.dart';
import 'package:cats_api_test/bloc/data_object/cat_object.dart';

class CatObjectLoaded extends CatObjectState {
  final List<Cat> cats;
  final bool hasReachedMax;

  const CatObjectLoaded({
    this.cats,
    this.hasReachedMax,
  });

  CatObjectLoaded copyWith({List<Cat> cats, bool hasReachedMax}) {
    return CatObjectLoaded(
      cats: cats ?? this.cats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      "CatObjectLoaded { cat: ${cats.length}, hasReachedMax: $hasReachedMax }";
}
