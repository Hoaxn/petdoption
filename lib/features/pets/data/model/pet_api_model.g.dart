// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetApiModel _$PetApiModelFromJson(Map<String, dynamic> json) => PetApiModel(
      petId: json['_id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String,
      gender: json['gender'] as String,
      description: json['description'] as String,
      color: json['color'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PetApiModelToJson(PetApiModel instance) =>
    <String, dynamic>{
      '_id': instance.petId,
      'name': instance.name,
      'age': instance.age,
      'species': instance.species,
      'breed': instance.breed,
      'gender': instance.gender,
      'description': instance.description,
      'color': instance.color,
      'image': instance.image,
    };
