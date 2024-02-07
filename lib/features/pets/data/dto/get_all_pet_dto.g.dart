// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_pet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPetsDTO _$GetAllPetsDTOFromJson(Map<String, dynamic> json) =>
    GetAllPetsDTO(
      success: json['success'] as bool?,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => PetApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPetsDTOToJson(GetAllPetsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
