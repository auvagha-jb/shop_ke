import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';

class UsersTable extends ApiService {
  Future<ServiceResponse> insertUser(Customer customer, User user) async {
    final endpoint = route("user/");
    customer.firebaseId = user.uid;
    ServiceResponse serviceResponse =
        await super.post(endpoint: endpoint, map: customer.toMap());

    if (!serviceResponse.status) {
      user.delete();
    }

    return serviceResponse;
  }

  Future<Customer> getUserById(String id) async {
    final endpoint = route("user/$id");
    final Map customerMap = await super.getItem(endpoint);
    Customer customer;

    if (customerMap != null) {
      customer = Customer.fromMap(customerMap);
    }

    return customer;
  }

  Future<Customer> getUserByFirebaseId(String id) async {
    final endpoint = route("user/firebase/$id");
    final Map customerMap = await super.getItem(endpoint);
    Customer customer;

    if (customerMap != null) {
      customer = Customer.fromMap(customerMap);
    }

    return customer;
  }

  Future<bool> emailExists(String email) async {
    final endpoint = route("user/email-exists/$email");
    final Map responseMap = await super.getItem(endpoint);
    bool emailExists = responseMap['emailExists'];
    return emailExists;
  }
}
