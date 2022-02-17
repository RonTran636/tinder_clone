import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/bloc/card_provider/card_provider.dart';
import 'package:tinder_clone/utils/colors.dart';
import 'package:tinder_clone/utils/dimensions.dart';
import 'package:tinder_clone/utils/fonts.dart';

class TinderCard extends StatefulWidget {
  const TinderCard(
      {Key? key,
      required this.imageUrl,
      required this.firstName,
      this.age,
      this.textSize})
      : super(key: key);

  final String imageUrl;
  final String firstName;
  final double? textSize;
  final int? age;

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.startPosition(details);
      },
      onPanUpdate: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.updatePosition(details);
      },
      onPanEnd: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);
        provider.endPosition();
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          final provider = Provider.of<CardProvider>(context);
          final position = provider.position;
          final animateDuration = provider.isDragging ? 0 : 400;

          //Set up offset when animating
          final center = constraint.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotateMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: animateDuration),
            transform: rotateMatrix..translate(position.dx, position.dy),
            child: _frontCard(),
          );
        },
      ),
    );
  }

  Widget _frontCard() => Container(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimen.defaultBorderRadius),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
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
                        widget.firstName,
                        style: TextStyle(
                          fontSize: widget.textSize ?? AppFont.fontSizeLarge,
                          color: AppColor.textColor,
                        ),
                      ),
                      SizedBox(width: 8.sz),
                      //Age will be pick randomly between 15 to 30
                      if (widget.age != null)
                        Text(
                          widget.age.toString(),
                          style: TextStyle(
                            fontSize: widget.textSize ?? AppFont.fontSizeLarge,
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
                        width: widget.textSize != null ? 6.sz : 12.sz,
                        height: widget.textSize != null ? 6.sz : 12.sz,
                      ),
                      SizedBox(width: AppDimen.defaultMargin / 2),
                      Text(
                        "Recently Active",
                        style: TextStyle(
                          fontSize: widget.textSize != null
                              ? widget.textSize! / 1.5
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final screenSize = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(screenSize);
    });
  }
}
