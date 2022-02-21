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
      await _loadCurrentUser(_listUser.first.id,0)
          .whenComplete(() => emit(HomeState.loaded(userList: _listUser)));
    });
  }

  Future<void> _loadCurrentUser(String userId,int index) async {
    await _apiHelper.getCurrentUserDetail(userId).then((value) {
      print("new data: $value");
      _listUser[index] = value;
    });
  }

  void _onLikeUser(HomeLikeUser event, Emitter<HomeState> emit) async {
    //Add user to liked list
    likedListUser.add(event.user);
    final index = _listUser.indexOf(event.user);
    if (index == _listUser.length) return;
    //Get data detail of the next user
    await _loadCurrentUser(_listUser[index+1].id,index+1)
        .whenComplete(
      () {
        print("current list: $_listUser");
        emit(const HomeState.loading());
        emit(HomeState.loaded(userList: _listUser));
      },
    );
  }

  void _onPassUser(HomePassUser event, Emitter<HomeState> emit) async {
    //Add user to passed list
    passedListUser.add(event.user);
    final index = _listUser.indexOf(event.user);
    if (index == _listUser.length) return;
    //Get data detail of the next user
    await _loadCurrentUser(_listUser[index+1].id,index+1)
        .whenComplete(
          () {
        print("current list: $_listUser");
        emit(const HomeState.loading());
        emit(HomeState.loaded(userList: _listUser));
      },
    );
  }
}
