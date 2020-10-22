import 'package:shop_ke/core/models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future containsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('id');
  }

  Future<ServiceResponse> setCustomer(Map<String, dynamic> customerMap) async {
    bool status = false;
    dynamic response;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //Remember the id needs to be set
      customerMap.forEach((attribute, value) async {
        await prefs.setString(attribute, value);
      });

      customerMap.forEach((attribute, value) async {
        print("$attribute => ${prefs.getString(attribute)}");
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
        return "No shared preferences";
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
