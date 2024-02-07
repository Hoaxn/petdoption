import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String? petId;
  final String name;
  final String age;
  final String species;
  final String breed;
  final String gender;
  final String description;
  final String? color;
  final String? image;

  @override
  List<Object?> get props =>
      [petId, name, age, species, breed, gender, description, color, image];

  const PetEntity({
    this.petId,
    required this.name,
    required this.age,
    required this.species,
    required this.breed,
    required this.gender,
    required this.description,
    this.color,
    this.image,
  });

  factory PetEntity.fromJson(Map<String, dynamic> json) {
    return PetEntity(
      petId: json['petId'] as String?,
      name: json['name'] as String,
      age: json['age'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String,
      gender: json['gender'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petId': petId,
      'name': name,
      'age': age,
      'species': species,
      'breed': breed,
      'gender': gender,
      'description': description,
      'color': color,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'PetEntity(petId: $petId, name: $name, age: $age, species: $species, breed: $breed, gender: $gender, description: $description, color: $color image: $image)';
  }
}
