class ExampleUser {
  int id;
  String name;
  String username;
  ExampleUser({this.id, this.name, this.username});

  ExampleUser.initial()
      : id = 0,
        name = '',
        username = '';

  ExampleUser.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}
