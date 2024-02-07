import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:pet_adoption_app/config/constants/hive_table_constant.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';
import 'package:uuid/uuid.dart';

part 'pet_hive_model.g.dart';

final petHiveModelProvider = Provider(
  (ref) => PetHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.petTableId)
class PetHiveModel {
  @HiveField(0)
  final String petId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String breed;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String description;

  // @HiveField(7)
  // final String password;

  // empty constructor
  PetHiveModel.empty()
      : this(
          petId: '',
          name: '',
          age: '',
          species: '',
          breed: '',
          gender: '',
          description: '',
          // password: '',
        );

  // Constructor
  PetHiveModel({
    String? petId,
    required this.name,
    required this.age,
    required this.species,
    required this.breed,
    required this.gender,
    required this.description,
    // required this.password,
  }) : petId = petId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  PetEntity toEntity() => PetEntity(
        petId: petId,
        name: name,
        age: age,
        species: species,
        breed: breed,
        gender: gender,
        description: description,
        // password: password,
      );

  // Convert Entity to Hive Object
  PetHiveModel toHiveModel(PetEntity entity) => PetHiveModel(
        // petId: const Uuid().v4(),
        // petId: petId,
        name: entity.name,
        age: entity.age,
        species: entity.species,
        breed: entity.breed,
        gender: entity.gender,
        description: entity.description,
        // password: entity.password,
      );

  // // Convert Entity List to Hive List
  // List<PetHiveModel> toHiveModelList(List<PetEntity> entities) => entities
  //     .map(
  //       (entity) => toHiveModel(entity),
  //     )
  //     .toList();

  // Convert Hive List to Entity List
  List<PetEntity> toEntityList(List<PetHiveModel> models) => models
      .map(
        (model) => model.toEntity(),
      )
      .toList();

  @override
  String toString() {
    return 'petId: $petId, name: $name, age: $age, species: $species, breed: $breed, gender: $gender, description: $description';
  }
}
