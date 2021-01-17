import 'package:flutter/cupertino.dart';

customContainer(final color, double width, double height, final child) {
  return Container(
    width: width,
    height: height,
    child: child,
    color: color,
  );
}
