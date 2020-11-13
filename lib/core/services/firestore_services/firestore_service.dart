import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ke/core/models/service_response.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference _collectionRef;
  final String collectionName;

  FirestoreService(this.collectionName) {
    _collectionRef = _db.collection(collectionName);
  }

  Future<ServiceResponse> add(dynamic collectionModel) async {
    bool status = false;
    String response;

    try {
      //Add new document to collection with the given uid
      await _collectionRef.add(collectionModel.toMap());
      status = true;
      response = 'New item added to $collectionName collection';
      print(response);
    } catch (e) {
      print('Add $collectionName exception: $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }

  Future update(dynamic collectionModel) async {
    bool status = false;
    String response;

    try {
      CollectionReference ref = _db.collection(collectionName);
      await ref.doc(collectionModel.id).update(collectionModel.toMap());
      status = true;
      response = 'Updated item in $collectionName collection';
      print(response);

    } catch (e) {
      print('Update exception $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }

  Future delete(String id) async {
    bool status = false;
    String response;

    try {
      await _collectionRef.doc(id).delete();
      status = true;
      response = 'Deleted item in $collectionName collection';

    } catch (e) {
      print('Delete exception $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }
}
