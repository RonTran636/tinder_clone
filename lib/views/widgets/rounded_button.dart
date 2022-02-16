import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder_clone/utils/dimensions.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final Color iconColor;
  final Color color;

  const RoundedButton({
    Key? key,
    required this.iconPath,
    required this.color,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12.sz),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: iconColor,width: 2.sz)
        ),
        child: SvgPicture.asset(
          iconPath,
          fit: BoxFit.contain,
          color: iconColor,
        ),
      ),
    );
  }
}
