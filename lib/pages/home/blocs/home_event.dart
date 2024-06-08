part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetListProductEvent extends HomeEvent {
  GetListProductEvent();
}

class LoadMoreProductEvent extends HomeEvent {
  LoadMoreProductEvent();
}
