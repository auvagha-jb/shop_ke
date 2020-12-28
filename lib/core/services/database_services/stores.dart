import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';

class Stores extends ApiService {
  Future<ServiceResponse> insertStore(Store store, String userId) async {
    String endpoint = route('store/');
    Map<String, dynamic> map = {
      "store": store.toMap(),
      "user": {"userId": userId}
    };

    ServiceResponse serviceResponse =
        await super.post(endpoint: endpoint, map: map);
    return serviceResponse;
  }

  Future<Store> getStoreByUserId(String id) async {
    String endpoint = route('store/user/$id');
    List stores = await super.getList(endpoint);
    Store store;

    if (stores.length > 0) {
      store = Store.fromMap(stores.first);
    }

    return store;
  }
}
