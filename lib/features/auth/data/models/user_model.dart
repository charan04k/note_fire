import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    // required super.id,
    required super.name,
    required super.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromJson(
      Map<String, dynamic> json,
      String id,
      ) {
    return UserModel(
      // id: id,
      name: json['name'],
      email: json['email'],
    );
  }
}