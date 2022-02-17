import 'package:flutter/material.dart';
import 'package:tinder_clone/data/model/user/user.dart';
import 'package:tinder_clone/utils/colors.dart';
import 'package:tinder_clone/utils/dimensions.dart';
import 'package:tinder_clone/utils/fonts.dart';
import 'package:tinder_clone/views/widgets/tinder_card.dart';

class ListUserScreen extends StatelessWidget {
  const ListUserScreen({Key? key, required this.tag, required this.listUser})
      : super(key: key);
  final String tag;
  final List<User> listUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          tag,
          style: TextStyle(
            fontSize: AppFont.fontSizeMedium,
            color: AppColor.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: listUser.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppDimen.defaultMargin / 4,
                  crossAxisSpacing: AppDimen.defaultMargin / 4,
                  childAspectRatio: 9 / 16),
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                return TinderCard(
                  imageUrl: listUser[index].picture,
                  firstName: listUser[index].firstName,
                  age: listUser[index].age!,
                  textSize: AppFont.fontSizeSmall,
                );
              })
          : Center(
              child: Text(
                "Nothing in here",
                style: TextStyle(
                  fontSize: AppFont.fontSizeLarge,
                  color: AppColor.textColor,
                ),
              ),
            ),
    );
  }
}
