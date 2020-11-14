import 'customer.dart';

class Store {
  String userId;
  String logo; //TODO: upload photo
  Map colorTheme; //{primaryColor, secondaryColor}
  String locationCoordinates; //{longitude, latitude}
  List<String> industries;
  int visitCount;
  //Non-collection fields
  List<Customer> subscribers;
}
