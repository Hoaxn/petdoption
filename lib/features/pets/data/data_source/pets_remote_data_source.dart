import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pet_adoption_app/config/constants/api_endpoint.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/core/network/local/hive_service.dart';
import 'package:pet_adoption_app/core/network/remote/http_service.dart';
import 'package:pet_adoption_app/core/shared_pref/user_shared_pref.dart';
import 'package:pet_adoption_app/features/pets/data/data_source/pets_local_data_source.dart';
import 'package:pet_adoption_app/features/pets/data/model/pet_api_model.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

final petRemoteDataSourceProvider = Provider<PetRemoteDataSource>(
  (ref) {
    return PetRemoteDataSource(
      ref.read(httpServiceProvider),
      ref.read(userSharedPrefsProvider),
      ref.read(petApiModelProvider),
    );
  },
);

class PetRemoteDataSource {
  final Dio dio;
  final PetApiModel petApiModel;
  final UserSharedPrefs userSharedPrefs;

  PetRemoteDataSource(this.dio, this.userSharedPrefs, this.petApiModel);

  Future<Either<Failure, Response>> getAllPets() async {
    try {
      Response response = await dio.get(ApiEndpoints.getAllPets);
      if (response.statusCode == 200) {
        final pets = response.data['pets'] as List<dynamic>;
        PetLocalDataSource ls = PetLocalDataSource(hiveService: HiveService());
        await ls.storePetDataInHive(pets);
        print('pets ${response.data}');
        return Right(response);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Future<Either<Failure, List<PetEntity>>> getAllPets() async {
  //   try {
  //     final response = await dio.get(
  //       ApiEndpoints.getAllPets,
  //     );

  //     if (response.statusCode == 200) {
  //       final petAddDTO = GetAllPetsDTO.fromJson(response.data);

  //       final entities = petApiModel.toEntityList(petAddDTO.data);

  //       return Right(entities);
  //     } else {
  //       return Left(
  //         Failure(
  //           error: 'Failed to retrieve Pets. ${response.statusCode}',
  //           statusCode: response.statusCode.toString(),
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: 'Failed to retrieve Pets. ${e.error.toString()}',
  //       ),
  //     );
  //   }
  // }

  Future<Either<Failure, bool>> addPet(PetEntity pet, File? file) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var minType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(file.path,
            filename: file.path.split("/").last,
            contentType: MediaType("image", minType!.split("/")[1]));
      }
      var request = {
        'petId': pet.petId,
        'name': pet.name,
        'age': pet.age,
        'species': pet.species,
        'breed': pet.breed,
        'gender': pet.gender,
        'description': pet.description,
        'color': pet.color,
      };

      var formData = FormData.fromMap({
        'image': image,
        'Request': jsonEncode(request),
      });
      Response response = await dio.post(
        ApiEndpoints.createPet,
        data: formData,
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, Response>> deletePet(String petId) async {
    try {
      Response response = await dio.delete("${ApiEndpoints.deletePet}/$petId");
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
