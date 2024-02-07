import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

part 'pet_api_model.g.dart';

final petApiModelProvider = Provider<PetApiModel>(
  (ref) => PetApiModel.empty(),
);

@JsonSerializable()
class PetApiModel {
  @JsonKey(name: '_id')
  final String petId;
  final String name;
  final String age;
  final String species;
  final String breed;
  final String gender;
  final String description;
  final String? color;
  final String? image;

  PetApiModel({
    required this.petId,
    required this.name,
    required this.age,
    required this.species,
    required this.breed,
    required this.gender,
    required this.description,
    this.color,
    this.image,
  });

  PetApiModel.empty()
      : petId = '',
        name = '',
        age = '',
        species = '',
        breed = '',
        gender = '',
        description = '',
        color = '',
        image = '';

  factory PetApiModel.fromJson(Map<String, dynamic> json) {
    return PetApiModel(
      petId: json['_id'] as String,
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

  // Convert Hive Object to Entity
  PetEntity toEntity() => PetEntity(
        petId: petId,
        name: name,
        age: age,
        species: species,
        breed: breed,
        gender: gender,
        description: description,
        color: color,
        image: image,
      );

  // Convert Entity to Hive Object
  PetApiModel toHiveModel(PetEntity entity) => PetApiModel(
        petId: entity.petId!,
        name: entity.name,
        age: entity.age,
        species: entity.species,
        breed: entity.breed,
        gender: entity.gender,
        description: entity.description,
        color: entity.color,
        image: entity.image,
      );

  List<PetApiModel> toHiveModelList(List<PetEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  // Convert Hive List to Entity List
  List<PetEntity> toEntityList(List<PetApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'PetApiModel(petId: $petId, name: $name, age: $age, species: $species, breed: $breed, gender: $gender, description: $description, color: $color, image: $image)';
  }
}
