import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  void _setSharedPreference(String attribute, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Null safety
    if (value == null) {
      print('$attribute is null');
      return;
    }

    switch (value.runtimeType) {
      case String:
        await prefs.setString(attribute, value);
        break;
      case bool:
        await prefs.setBool(attribute, value);
        break;
      default:
        throw Exception('Case for type ${value.runtimeType} not found');
        break;
    }
  }

  void _getSharedPreference(String attribute, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case String:
        print('$attribute => ${prefs.getString(attribute)}');
        break;
      case bool:
        print('$attribute => ${prefs.getBool(attribute)}');
        break;
      default:
        print('No type found for $attribute => type ${value.runtimeType}');
        break;
    }
  }

  Future getAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      if (keys == null) {
        throw new Exception('No shared preferences');
      }

      keys.forEach((element) {
        print(prefs.getString(element));
      });
      return keys;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<ServiceResponse> set(Map<String, dynamic> map) async {
    bool status = false;
    dynamic response;

    print('Map values to be set $map');

    try {
      //Remember the id needs to be set
      map.forEach((attribute, value) async {
        _setSharedPreference(attribute, value);
      });

      map.forEach((attribute, value) async {
        _getSharedPreference(attribute, value);
      });

      status = true;
      response = 'Customer set';
    } catch (e) {
      print('setCustomer $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }

  Future<bool> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<ServiceResponse> getCustomerId() async {
    var response;
    bool status = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      response = prefs.getString('userId');
      if (response == null) {
        throw new Exception('Something went wrong. Please log out and sign again');
      }
      status = true;
    } catch (e) {
      print('[SharedPreferencesService.getCustomerId] $e');
      throw e;
    }

    return ServiceResponse(status: status, response: response);
  }

  Future containsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userId');
  }

  Future<ServiceResponse> getCustomer() async {
    var response;
    var customer;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      customer = Customer.fromSharedPreferences(prefs);

      if (customer == null) {
        throw new Exception('Something went wrong. Please log out and sign in');
      } else {
        response = customer;
      }
    } catch (e) {
      print(e);
      response = generalExceptionResponse;
    }

    return ServiceResponse(status: response is Customer, response: response);
  }

  Future<ServiceResponse> getStore() async {
    var response;
    bool status = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Store store = Store.fromSharedPreferences(prefs);

      if (store == null) {
        throw new Exception("Could not find store details. Please log out and sign in");
      } else {
        response = store;
        status = true;
      }
    } catch (e) {
      print('[SharedPreferences.getStore] $e');
      response = "Could not fetch store details";
    }

    return ServiceResponse(status: status, response: response);
  }

  Future<ServiceResponse> getStoreName() async {
    var response;
    bool status = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String storeName = prefs.getString('storeName');
      status = true;
      response = storeName ?? 'My Store';
    } catch (e) {
      print(e);
      response = generalExceptionResponse;
    }

    return ServiceResponse(status: status, response: response);
  }

  Future<Map<String, dynamic>> getByKeys(List<String> keyList) async {
    Map<String, dynamic> response = {};
    bool status = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      for (String key in keyList) {
        response[key] = prefs.getString(key);
      }

      status = response.length == keyList.length;

      if (!status) {
        throw ("Ensure the keys match the sharedPreferences");
      }
    } catch (e) {
      print("[SharedPreferencesService.getByKeys] $e");
      throw (e);
    }

    return response;
  }
}
