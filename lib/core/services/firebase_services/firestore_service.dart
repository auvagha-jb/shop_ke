import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ke/core/models/customer.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService() {
    print('Hello from Firestore');
  }

  //The collections
  String _customerCollection = "Customers";

  String get customerCollection => _customerCollection;

  Future add(String collection, String uid, dynamic collectionModel) async {
    try {
      CollectionReference ref = _db.collection(collection);
      collectionModel.id = uid;

      //Add new document to collection with the given uid
      await ref.doc(uid).set(collectionModel.toMap());
      print("New item added to $collection collection");
      return true;
    } catch (e) {
      print("Add exception $e");
      return e.toString();
    }
  }

  Future getById(String collection, String id) async {
    try {
      CollectionReference ref = _db.collection(collection);

      final customerData = await ref.doc(id).get();
      final customer = Customer.fromMap(customerData.data());
      print("Customer from firebase customer");
      assert(customer != null);

      return customer;
    } catch (e) {
      print("getById exception $e");
      return e.toString();
    }
  }

  Future updateCustomer(String collection, dynamic collectionModel) async {
    try {
      CollectionReference ref = _db.collection(collection);

      await ref.doc(collectionModel.id).update(collectionModel.toMap());
      print("Updated item in $collection collection");
    } catch (e) {
      print("Update exception $e");
      return e.toString();
    }
  }
}
