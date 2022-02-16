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
  final _likedListUser = <User>[];
  final _passedListUser = <User>[];
  HomeBloc() : super(const HomeState.initial()) {
    on<HomeLoadInitialList>(_onLoadInitialList);
    on<HomeLikeUser>(_onLikeUser);
    on<HomePassUser>(_onPassUser);
    on<HomePassedList>(_onPassedListTapped);
    on<HomeLikedList>(_onLikedListTapped);
  }

  void _onLoadInitialList(HomeLoadInitialList event, Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    await _apiHelper.getListUser().then((value) {
      _listUser = value;
      print("data loaded: $value");
    }).whenComplete(() => emit(HomeState.loaded(userList: _listUser)));
  }

  void _onLikeUser(HomeLikeUser event, Emitter<HomeState> emit) {
    print("Like user called");
    emit(HomeState.loading());
    //Perform animation like

    //Add user to liked list
    _likedListUser.add(event.user);
    //Remove user from parent list
    _listUser.remove(event.user);
    emit(HomeState.loaded(userList: _listUser));
  }

  void _onPassUser(HomePassUser event, Emitter<HomeState> emit) {
    print("Unlike user called");
    emit(HomeState.loading());
    //Perform animation pass

    //Add user to passed list
    _passedListUser.add(event.user);
    //Remove user from parent list
    _listUser.remove(event.user);
    emit(HomeState.loaded(userList: _listUser));
  }

  void _onPassedListTapped(HomePassedList event, Emitter<HomeState> emit) {}

  void _onLikedListTapped(HomeLikedList event, Emitter<HomeState> emit) {}
}
