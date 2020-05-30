import 'package:equatable/equatable.dart';

abstract class CatObjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends CatObjectEvent {}