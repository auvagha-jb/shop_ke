class Customer {
  String userId; //Auto incremented in database
  String firebaseId; //Auto generated by firebase
  String firstName;
  String lastName;
  String email;
  String countryCode = '+254';
  String _phoneNumber;
  String fullPhoneNumber;
  String password;
  bool isShopOwner = false;

  Customer(); //Default Constructor

  //sets the phone number and fullPhoneNumber
  set phoneNumber(String phoneNumber) {
    //If the phone number has 10 digits i.e. with leading zero, cut it off
    if (phoneNumber.length == 10) {
      _phoneNumber = phoneNumber.substring(1);
    }
    //If not, leave the number as it is
    else {
      _phoneNumber = phoneNumber;
    }

    fullPhoneNumber = countryCode + phoneNumber;
  }

  String get phoneNumber => _phoneNumber;

  Customer.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    firebaseId = map['firebaseId'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    countryCode = map['countryCode'];
    phoneNumber = map['phoneNumber'];
    isShopOwner = map['isShopOwner'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firebaseId': firebaseId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'isShopOwner': isShopOwner,
    };
  }
}