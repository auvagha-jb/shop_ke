import 'package:shop_ke/core/models/color_theme.dart';
import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/models/location_coordinate.dart';

class Store {
  String userId;
  String name;
  String logo; //TODO: upload photo
  String physicalAddress;
  String industry;
  String county;

  //Future Works
  ColorTheme colorTheme;
  LocationCoordinate locationCoordinate;
  int visitCount;

  //Default values
  static const String defaultIndustry = 'Choose your industry';
  static const String defaultCounty = 'Choose your county';

  Store() {
    industry = defaultIndustry;
    county = defaultCounty;
  }

  //Non-collection fields
  List<Customer> subscribers;

  Store.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    name = map['name'];
    logo = map['logo'];
    physicalAddress = map['physicalAddress'];
    industry = map['industry'];
    county = map['county'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'logo': logo,
      'physicalAddress': physicalAddress,
      'industry': industry,
      'county': county
    };
  }
}
