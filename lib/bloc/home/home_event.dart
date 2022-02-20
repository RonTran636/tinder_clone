part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadInitialList() = HomeLoadInitialList;

  const factory HomeEvent.passUser(User user) = HomePassUser;

  const factory HomeEvent.likeUser(User user) = HomeLikeUser;

  const factory HomeEvent.openPassedList() = HomePassedList;

  const factory HomeEvent.openLikedList() = HomeLikedList;

  const factory HomeEvent.loadCurrentUser(String userId) = HomeLoadCurrentUser;
}
