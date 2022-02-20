import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tinder_clone/utils/colors.dart';
import 'package:tinder_clone/utils/dimensions.dart';
import 'package:tinder_clone/utils/fonts.dart';

class TinderCard extends StatelessWidget {
  const TinderCard(
      {Key? key,
      required this.imageUrl,
      required this.firstName,
      this.dateOfBirth,
      this.textSize})
      : super(key: key);

  final String imageUrl;
  final String firstName;
  final double? textSize;
  final String? dateOfBirth;

  @override
  Widget build(BuildContext context) {
    final age = dateOfBirth != null ? dateToAge(dateOfBirth!) : null;
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimen.defaultBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              alignment: const Alignment(-0.3, 0),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.7, 1],
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                //User's name
                Row(
                  children: [
                    Text(
                      firstName,
                      style: TextStyle(
                        fontSize: textSize ?? AppFont.fontSizeLarge,
                        color: AppColor.textColor,
                      ),
                    ),
                    SizedBox(width: 8.sz),
                    //Age will be pick randomly between 15 to 30
                    if (age != null)
                      Text(
                        age.toString(),
                        style: TextStyle(
                          fontSize: textSize ?? AppFont.fontSizeLarge,
                          color: AppColor.textColor,
                        ),
                      )
                  ],
                ),
                //Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.appLikeColor,
                      ),
                      width: textSize != null ? 6.sz : 12.sz,
                      height: textSize != null ? 6.sz : 12.sz,
                    ),
                    SizedBox(width: AppDimen.defaultMargin / 2),
                    Text(
                      "Recently Active",
                      style: TextStyle(
                        fontSize: textSize != null
                            ? textSize! / 1.5
                            : AppFont.fontSizeMedium,
                        color: AppColor.textColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int dateToAge(String date) {
    final dateTime = DateTime.parse(date);
    final chosen = dateTime.millisecondsSinceEpoch;
    final now = DateTime.now().millisecondsSinceEpoch;
    var age = (now - chosen) ~/ (365 * 24 * 60 * 60 * 1000);
    if (Jiffy().dayOfYear < Jiffy(dateTime).dayOfYear) age--;
    return age;
  }
}
