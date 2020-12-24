import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/service_response.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference _collectionRef;
  final String collectionName;

  FirestoreService(this.collectionName) {
    _collectionRef = _db.collection(collectionName);
  }

  Future<ServiceResponse> add({
    @required dynamic model,
    @required String idField,
  }) async {
    bool status = false;
    String response;

    try {
      //Add new document to collection with the given uid
      final DocumentReference docReference =
          await _collectionRef.add(model._toMap());

      response = docReference.id;
      status = true;

      //Set {collection}Id field to the document
      _updateWithId(idField: idField, collectionId: docReference.id);
      print('Add response : $response');

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
      await _collectionRef
          .doc(collectionModel.firebaseId)
          .update(collectionModel._toMap());
      status = true;
      response = 'Updated item in $collectionName collection';
      print(response);
    } catch (e) {
      print('Update exception $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }

  Future getById(String id) async {
    bool status = false;
    dynamic response;

    try {
      final DocumentSnapshot documentSnapshot =
      await _collectionRef.doc(id).get();
      response = documentSnapshot.data();
      status = response != null;
    } catch (e) {
      print('getById exception $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }


  Future _updateWithId({
    @required String idField,
    @required String collectionId,
  }) async {
    bool status = false;
    String response;

    try {
      await _collectionRef.doc(collectionId).update({idField: collectionId});

      status = true;
      response = 'Updated id in $collectionName collection';
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
