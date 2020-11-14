import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future containsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('id');
  }

  void setSharedPreference(String attribute, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case String:
        await prefs.setString(attribute, value);
        break;
      case bool:
        await prefs.setBool(attribute, value);
        break;
      default:
        throw Exception('Case for type ${value.runtimeType} not found');
    }
  }

  void getSharedPreference(String attribute, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case String:
        print('$attribute => ${prefs.getString(attribute)}');
        break;
      case bool:
        print('$attribute => ${prefs.getBool(attribute)}');
        break;
    }
  }

  Future<ServiceResponse> setCustomer(Map<String, dynamic> customerMap) async {
    bool status = false;
    dynamic response;

    try {
      //Remember the id needs to be set
      customerMap.forEach((attribute, value) async {
        setSharedPreference(attribute, value);
      });

      customerMap.forEach((attribute, value) async {
        getSharedPreference(attribute, value);
      });

      status = true;
      response = 'Customer set';
    } catch (e) {
      print('setCustomer $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }

  Future<ServiceResponse> getCustomer() async {
    var response;
    var customer;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      customer = Customer.fromMap({
        'id': prefs.getString('id'),
        'firstName': prefs.getString('firstName'),
        'lastName': prefs.getString('lastName'),
        'countryCode': prefs.getString('countryCode'),
        'phoneNumber': prefs.getString('phoneNumber'),
        'email': prefs.getString('email'),
        'isShopOwner': prefs.getBool('isShopOwner'),
      });

      if (customer == null) {
        response = nullValueException('User');
      } else {
        response = customer;
      }
    } catch (e) {
      print(e);
      response = generalExceptionResponse;
    }

    return ServiceResponse(status: customer is Customer, response: response);
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

  Future<bool> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
