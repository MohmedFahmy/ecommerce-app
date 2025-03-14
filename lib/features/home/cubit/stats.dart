

import '../home data/model/model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

final class TestLoadingState extends HomeState {}

final class TestFailedState extends HomeState {}

final class TestPassedState extends HomeState {
  List<Model> list;
  TestPassedState({required this.list});
}
