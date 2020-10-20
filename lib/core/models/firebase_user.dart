class FirebaseUser {
  String user;
  String token;

  FirebaseUser.fromMap(Map<String, dynamic> map) {
    user = map['user'];
    token = map['token'];
  }

  Map<String, dynamic> toMap(FirebaseUser firebaseUser) {
    return {
      'user': firebaseUser.user,
      'token': firebaseUser.token,
    };
  }
}
