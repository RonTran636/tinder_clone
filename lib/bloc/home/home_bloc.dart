import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tinder_clone/data/model/user/user.dart';
import 'package:tinder_clone/data/network/api_helper.dart';
import 'package:tinder_clone/main.dart';
import 'package:tinder_clone/utils/fonts.dart';

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

  void _onLoadInitialList(HomeLoadInitialList event,
      Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    await _apiHelper.getListUser().then((value) {
      final _newList = <User>[];
      for (var user in value) {
        _newList.add(user.copyWith(age: Random().nextInt(15) + 15));
      }
      _listUser = _newList;
    }).whenComplete(() => emit(HomeState.loaded(userList: _listUser)));
  }

  void _onLikeUser(HomeLikeUser event, Emitter<HomeState> emit) async {
    snackBarKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          "LIKED",
          style: TextStyle(
            fontSize: AppFont.fontSizeSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
    emit(const HomeState.loading());
    //Add user to liked list
    likedListUser.add(event.user);
    //Remove user from parent list
    _listUser.remove(event.user);
    await Future.delayed(const Duration(milliseconds: 500), () {}).whenComplete(
          () => emit(HomeState.loaded(userList: _listUser)),
    );
  }

  void _onPassUser(HomePassUser event, Emitter<HomeState> emit) async {
    snackBarKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          "PASSED",
          style: TextStyle(
            fontSize: AppFont.fontSizeSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
    emit(const HomeState.loading());
    //Add user to passed list
    passedListUser.add(event.user);
    //Remove user from parent list
    _listUser.remove(event.user);
    await Future.delayed(const Duration(milliseconds: 500), () {}).whenComplete(
          () => emit(HomeState.loaded(userList: _listUser)),
    );
  }
}
