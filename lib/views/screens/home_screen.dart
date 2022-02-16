import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            loaded: (listUser) => Column(
              children: [
                SizedBox(height: AppDimen.defaultMargin),
                Expanded(
                  child: Stack(
                    children: listUser.reversed
                        .map(
                          (value) => TinderCard(
                            firstName: value.firstName,
                            imageUrl: value.picture,
                          ),
                        )
                        .toList(),
                  ),
                ),
                _actionButtons(listUser),
                SizedBox(height: AppDimen.defaultMargin),
                _listButton(),
                SizedBox(height: 16.sz)
              ],
            ),
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

  @override
  void initState() {
    super.initState();
  }

  Widget _actionButtons(List<User> listUser) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RoundedButton(
          iconPath: Assets.icons.clear.path,
          color: AppColor.buttonBackground,
          iconColor: AppColor.appRedColor,
          onPressed: () => context.read<HomeBloc>()
            ..add(
              HomeEvent.passUser(listUser[0]),
            ),
        ),
        SizedBox(width: AppDimen.defaultMargin / 2),
        RoundedButton(
          iconPath: Assets.icons.star.path,
          color: AppColor.buttonBackground,
          iconColor: AppColor.appBlue,
          onPressed: () {},
        ),
        SizedBox(width: AppDimen.defaultMargin / 2),
        RoundedButton(
          iconPath: Assets.icons.heart.path,
          color: AppColor.buttonBackground,
          iconColor: AppColor.appLikeColor,
          onPressed: () => context.read<HomeBloc>()
            ..add(
              HomeEvent.likeUser(listUser[0]),
            ),
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
                      listUser: context.read<HomeBloc>().passedListUser, tag: "Second Look",
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
                      listUser: context.read<HomeBloc>().likedListUser, tag: "Liked List",
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
