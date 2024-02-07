import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String city;
  final String country;
  final String email;
  final String password;
  final String? image;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        phoneNumber,
        city,
        country,
        email,
        password,
        image
      ];

  const UserEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.city,
    required this.country,
    required this.email,
    required this.password,
    this.image,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        firstName: json["fname"],
        lastName: json["lname"],
        phoneNumber: json["phone"],
        city: json["city"],
        country: json["country"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": firstName,
        "lname": lastName,
        "phone": phoneNumber,
        "city": city,
        "country": country,
        "email": email,
        "password": password,
        "image": image,
      };
}
