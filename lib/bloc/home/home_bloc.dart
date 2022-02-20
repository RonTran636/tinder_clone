import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tinder_clone/data/model/user/user.dart';
import 'package:tinder_clone/data/network/api_helper.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _apiHelper = ApiHelper();
  late final List<User> _listUser;
  final likedListUser = <User>[];
  final passedListUser = <User>[];

  HomeBloc() : super(const HomeState.initial()) {
    on<HomeLoadInitialList>(_onLoadInitialList);
    on<HomeLikeUser>(_onLikeUser);
    on<HomePassUser>(_onPassUser);
  }

  void _onLoadInitialList(
      HomeLoadInitialList event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    await _apiHelper.getListUser().then((value) async {
      _listUser = value;
      await _loadCurrentUser(_listUser[0].id)
          .whenComplete(() => emit(HomeState.loaded(userList: _listUser)));
    });
  }

  Future<void> _loadCurrentUser(String userId) async {
    await _apiHelper.getCurrentUserDetail(userId).then((value) {
      _listUser[0] = value;
    });
  }

  void _onLikeUser(HomeLikeUser event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    //Add user to liked list
    likedListUser.add(event.user);
    //Remove user from parent list
    _listUser.remove(event.user);
    //Get data detail of the next user
    await _loadCurrentUser(_listUser[0].id).whenComplete(
      () => emit(
        HomeState.loaded(userList: _listUser),
      ),
    );
  }

  void _onPassUser(HomePassUser event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    //Add user to passed list
    passedListUser.add(event.user);
    //Remove user from parent list
    _listUser.remove(event.user);
    //Get data detail of the next user
    await _loadCurrentUser(_listUser[0].id).whenComplete(
      () => emit(
        HomeState.loaded(userList: _listUser),
      ),
    );
  }
}
