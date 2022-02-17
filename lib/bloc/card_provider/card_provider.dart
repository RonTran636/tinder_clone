import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  bool _isDragging = false;

  bool get isDragging => _isDragging;
  double _angle = 0.0;
  Size _screenSize = Size.zero;

  Offset _position = Offset.zero;

  Offset get position => _position;

  double get angle => _angle;

  void setScreenSize(Size size) => _screenSize = size;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = position.dx;
    _angle = 45 * x / _screenSize.width ;
    notifyListeners();
  }

  void endPosition() {
    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }
}
