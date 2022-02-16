import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_clone/utils/assets.gen.dart';
import 'package:tinder_clone/utils/colors.dart';
import 'package:tinder_clone/utils/dimensions.dart';
import 'package:tinder_clone/utils/fonts.dart';
import 'package:tinder_clone/views/widgets/rounded_button.dart';
import 'package:tinder_clone/views/widgets/tinder_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: AppDimen.defaultMargin),
          Expanded(
            child: TinderCard(
              firstName: "Josh",
              imageUrl: "",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundedButton(
                iconPath: Assets.icons.clear.path,
                color: AppColor.buttonBackground,
                iconColor: AppColor.appRedColor,
                onPressed: () {},
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
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: AppDimen.defaultMargin),
          Container(
            color: AppColor.background,
            padding: EdgeInsets.all(16.sz),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
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
                    onTap: () {},
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
          ),
          SizedBox(height: 16.sz)
        ],
      ),
    );
  }
}
