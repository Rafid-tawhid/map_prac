import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid=Uuid();

class Place{

  Place({required this.title,required this.image,required this.location,String? id}) :id=id?? uuid.v4();
  final String id; 
  final String title;
  final File image;
  final PlaceLocation location;
}

class PlaceLocation{
  final double latitude;
  final double longatude;
  final String address;

  PlaceLocation({required this.latitude,required this.longatude,required this.address});
}