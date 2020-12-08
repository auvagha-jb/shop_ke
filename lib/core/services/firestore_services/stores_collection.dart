import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/firestore_services/customers_collection.dart';
import 'package:shop_ke/core/services/firestore_services/firestore_service.dart';
import 'package:shop_ke/locator.dart';

class StoresCollection extends FirestoreService {
  static final String _collectionName = 'stores';

  String get collectionName => _collectionName;

  CollectionReference _storesReference;
  CustomersCollection _customersCollection = locator<CustomersCollection>();

  StoresCollection() : super(_collectionName) {
    _storesReference = FirebaseFirestore.instance.collection(_collectionName);
  }

  Future getStore(String userId) async {
    bool status = false;
    var response;

    try {
      QuerySnapshot querySnapshot =
          await _storesReference.where('userId', isEqualTo: userId).get();
      QueryDocumentSnapshot snapshot = querySnapshot.docs.first;

      status = snapshot.exists;
      if (status) {
        response = snapshot.data();
      }
    } catch (e) {
      print('getStoreException $e');
      response = e.toString();
    }

    print(response);
    return ServiceResponse(status: status, response: response);
  }

  Future<List<Customer>> getSubscribers(String storeId) async {
    List<Customer> subscribers = [];
    QuerySnapshot querySnapshot =
        await _storesReference.where('storeId', isEqualTo: storeId).get();

    for (var doc in querySnapshot.docs) {
      String userId = doc.data()['userId'];
      ServiceResponse serviceResponse =
          await _customersCollection.getCustomerById(userId);
      if (serviceResponse.response is Customer) {
        Customer customer = serviceResponse.response as Customer;
        subscribers.add(customer);
      }
    }

    return subscribers;
  }

  Future<List<Store>> getSubscriptions(String userId) async {
    List<Store> subscriptions = [];
//    QuerySnapshot querySnapshot =
//        await _subscriptionsReference.where('userId', isEqualTo: userId).get();
//
//    for (var doc in querySnapshot.docs) {
//      String userId = doc.data()['userId'];
//      ServiceResponse serviceResponse =
//      await _customersCollection.getCustomerById(userId);
//      if (serviceResponse.response is Store) {
//        Store store = serviceResponse.response as Store;
//        subscriptions.add(store);
//      }
//    }

    return subscriptions;
  }
}
