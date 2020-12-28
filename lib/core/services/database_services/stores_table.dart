import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';

class StoresTable extends ApiService {
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

  Future<Store> getStoreByUserId(String userId) async {
    String endpoint = route('store/user/$userId');
    Map storeMap = await super.getItem(endpoint);
    Store store;

    if (storeMap != null) {
      store = Store.fromMap(storeMap);
    }

    return store;
  }
}
