import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pet_adoption_app/features/pets/data/model/pet_api_model.dart';

part 'get_all_pet_dto.g.dart';

@JsonSerializable()
class GetAllPetsDTO {
  final bool? success;
  final int count;
  final List<PetApiModel> data;

  GetAllPetsDTO({
    this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllPetsDTOToJson(this);

  factory GetAllPetsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPetsDTOFromJson(json);
}
