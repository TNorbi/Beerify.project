import 'package:flutter/cupertino.dart';

class Beer {
  String name;
  String brand;
  String ? edition;
  String ? releasedate;
  AssetImage ? image;
  String ? type;
  String ? alcohol;

  // TODO: kiegészíteni két fielddel: required this.brand, required this.image
  Beer({required this.name, required this.brand});
}
