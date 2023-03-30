class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? mail;
  String? image;

  UserModel({this.id, this.image, this.firstName, this.lastName, this.mail});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mail = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['avatar'];
  }
}
