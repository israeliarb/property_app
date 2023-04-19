import 'package:flutter/cupertino.dart';

Size getScreenSize(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  return screenSize;
}
