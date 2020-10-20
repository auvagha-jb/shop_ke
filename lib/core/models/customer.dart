class Customer {
  String id;
  String firstName;
  String lastName;
  String email;
  String countryCode;
  String _phoneNumber;
  String fullPhoneNumber;
  String password;

  Customer(); //Default Constructor

  //sets the phone number and full phonenumber
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
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    countryCode = map['countryCode'];
    phoneNumber = map['phoneNumber'];
    fullPhoneNumber = map['fullPhoneNumber'];
  }

  Map<String, dynamic> toMap() {
    assert(id != null);
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'fullPhoneNumber': fullPhoneNumber,
    };
  }
}
