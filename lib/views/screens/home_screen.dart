import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:tinder_clone/bloc/home/home_bloc.dart';
import 'package:tinder_clone/data/model/user/user.dart';
import 'package:tinder_clone/utils/assets.gen.dart';
import 'package:tinder_clone/utils/colors.dart';
import 'package:tinder_clone/utils/dimensions.dart';
import 'package:tinder_clone/utils/fonts.dart';
import 'package:tinder_clone/views/screens/list_user_screen.dart';
import 'package:tinder_clone/views/widgets/rounded_button.dart';
import 'package:tinder_clone/views/widgets/tinder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.when(
            initial: () => Container(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (listUser) {
              return Column(
                children: [
                  SizedBox(height: AppDimen.defaultMargin),
                  Expanded(
                    child: SwipableStack(
                      detectableSwipeDirections: const {
                        SwipeDirection.right,
                        SwipeDirection.left,
                        SwipeDirection.up
                      },
                      controller: _controller,
                      stackClipBehaviour: Clip.none,
                      horizontalSwipeThreshold: 0.8,
                      verticalSwipeThreshold: 0.8,
                      onSwipeCompleted: (index, direction) {
                        switch (direction) {
                          case SwipeDirection.left:
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeEvent.passUser(listUser[index]));
                            });
                            break;

                          case SwipeDirection.right:
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeEvent.likeUser(listUser[index]));
                            });
                            break;

                          case SwipeDirection.up:
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeEvent.likeUser(listUser[index]));
                            });
                            break;
                        }
                      },
                      builder: (context, swipeProperty) {
                        final itemIndex = swipeProperty.index % listUser.length;
                        return Stack(
                          children: listUser.reversed
                              .map(
                                (e) => TinderCard(
                                  imageUrl: listUser[itemIndex].picture,
                                  firstName: listUser[itemIndex].firstName,
                                  dateOfBirth: listUser[itemIndex].dateOfBirth,
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                  _actionButtons(listUser.reversed.toList()),
                  SizedBox(height: AppDimen.defaultMargin),
                  _listButton(),
                  SizedBox(height: 16.sz)
                ],
              );
            },
            loadError: (exception) => Center(
              child: Text(
                "Something went wrong, please try again",
                style: TextStyle(
                    fontSize: AppFont.fontSizeLarge, color: AppColor.textColor),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _actionButtons(List<User> listUser) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RoundedButton(
          iconPath: Assets.icons.clear.path,
          color: AppColor.buttonBackground,
          iconColor: AppColor.appRedColor,
          onPressed: () {
            _controller.next(
              swipeDirection: SwipeDirection.left,
              duration: const Duration(
                milliseconds: 500,
              ),
            );
          },
        ),
        SizedBox(width: AppDimen.defaultMargin / 2),
        RoundedButton(
          iconPath: Assets.icons.star.path,
          color: AppColor.buttonBackground,
          iconColor: AppColor.appBlue,
          onPressed: () {
            _controller.next(
              swipeDirection: SwipeDirection.up,
              duration: const Duration(
                milliseconds: 500,
              ),
            );
          },
        ),
        SizedBox(width: AppDimen.defaultMargin / 2),
        RoundedButton(
          iconPath: Assets.icons.heart.path,
          color: AppColor.buttonBackground,
          iconColor: AppColor.appLikeColor,
          onPressed: () {
            _controller.next(
              swipeDirection: SwipeDirection.right,
              duration: const Duration(
                milliseconds: 500,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _listButton() {
    return Container(
      color: AppColor.background,
      padding: EdgeInsets.all(16.sz),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListUserScreen(
                      listUser: context.read<HomeBloc>().passedListUser,
                      tag: "Second Look",
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.edit_off,
                    color: AppColor.appRedColor,
                  ),
                  SizedBox(width: 8.sz),
                  Text(
                    "Second Look",
                    style: TextStyle(
                      fontSize: AppFont.fontSizeSmall,
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListUserScreen(
                      listUser: context.read<HomeBloc>().likedListUser,
                      tag: "Liked List",
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.heart_solid,
                    color: AppColor.appRedColor,
                  ),
                  SizedBox(width: 8.sz),
                  Text(
                    "Liked List",
                    style: TextStyle(
                      fontSize: AppFont.fontSizeSmall,
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
