class UserModel {
  int? id;
  String name;
  String email;
  String password;
  bool isFavorite;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      this.isFavorite = false});

  factory UserModel.fromMap({required Map<String, dynamic> data}) => UserModel(
        id: data['uid'],
        name: data['Name'],
        email: data['Email'],
        password: data['Password'].toString(),
        isFavorite: data['isFavorite'] ?? false,
      );

  Map<String, dynamic> get toMap => {
        'uid': id,
        'Name': name,
        'Email': email,
        'Password': password.toString(),
        'isFavorite': isFavorite,
      };
}
