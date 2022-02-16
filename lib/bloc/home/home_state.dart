part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState{
  const factory HomeState.initial() = HomeInitial;
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.loaded({required List<User> userList}) = HomeLoaded;
  const factory HomeState.loadError({Exception? exception}) = HomeLoadError;
}
