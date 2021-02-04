import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_ke/core/models/app_models/color_theme.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/app_models/location_coordinate.dart';

class Store {
  String storeId;
  String storeName;
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
  static const idField = "storeId";

  Store() {
    industry = defaultIndustry;
    county = defaultCounty;
  }

  //Non-collection fields
  List<Customer> subscribers;

  Store.fromMap(Map<String, dynamic> map) {
    storeId = map['storeId'];
    storeName = map['storeName'];
    logo = map['logo'];
    physicalAddress = map['physicalAddress'];
    industry = map['industry'];
    county = map['county'];
  }

  Store.fromSharedPreferences(SharedPreferences prefs) {
    Store.fromMap({
      'storeId': prefs.getString('storeId'),
      'userId': prefs.getString('userId'),
      'name': prefs.getString('name'),
      'logo': prefs.getString('logo'),
      'physicalAddress': prefs.getString('physicalAddress'),
      'industry': prefs.getString('industry'),
      'county': prefs.getString('county')
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'storeName': storeName,
      'logo': logo,
      'physicalAddress': physicalAddress,
      'industry': industry,
      'county': county
    };
  }
}
