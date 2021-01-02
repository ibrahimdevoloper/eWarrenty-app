import 'package:flutter/material.dart';

class Battery {
  final String battreyNumber;
  final int capacity;
  final String image;
  final String previewImage;

  Battery(
      {@required this.battreyNumber,
      @required this.capacity,
      @required this.image,
      @required this.previewImage});
}
