import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/config/constants/api_endpoint.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/core/network/remote/http_service.dart';
import 'package:pet_adoption_app/core/shared_pref/user_shared_pref.dart';
import 'package:pet_adoption_app/features/pets/data/model/pet_api_model.dart';

final likedPetRemoteDataSourceProvider = Provider<LikedPetRemoteDataSource>(
  (ref) {
    return LikedPetRemoteDataSource(
      ref.read(httpServiceProvider),
      ref.read(userSharedPrefsProvider),
      ref.read(petApiModelProvider),
    );
  },
);

class LikedPetRemoteDataSource {
  final Dio dio;
  final PetApiModel petApiModel;
  final UserSharedPrefs userSharedPrefs;

  LikedPetRemoteDataSource(this.dio, this.userSharedPrefs, this.petApiModel);

  Future<Either<Failure, Response>> getLikedPets() async {
    final data = await userSharedPrefs.getUserId();
    final tokenData = await userSharedPrefs.getUserToken();

    String? userId;
    String? token;

    data.fold(
      (failure) {
        // Handle the failure case here
      },
      (userIdValue) {
        userId = userIdValue;
      },
    );
    tokenData.fold(
      (failure) {
        // Handle the failure case here
      },
      (tokenValue) {
        token = tokenValue;
      },
    );
    try {
      Response response = await dio.get(
        "${ApiEndpoints.getLikedPetsByUserId}/$userId",
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
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

  Future<Either<Failure, bool>> saveLikedPet(String? petId) async {
    try {
      final data = await userSharedPrefs.getUserId();
      final tokenData = await userSharedPrefs.getUserToken();

      String? userId;
      String? token;

      data.fold(
        (failure) {
          // Handle the failure case here
        },
        (userIdValue) {
          userId = userIdValue;
        },
      );
      tokenData.fold(
        (failure) {
          // Handle the failure case here
        },
        (tokenValue) {
          token = tokenValue;
        },
      );

      final response = await dio.post(
        ApiEndpoints.saveLikedPet,
        data: {
          "petId": petId,
          "userId": userId,
        },
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
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

  Future<Either<Failure, Response>> removeLikedPet(String? petId) async {
    final data = await userSharedPrefs.getUserId();
    final tokenData = await userSharedPrefs.getUserToken();

    String? userId;
    String? token;

    data.fold(
      (failure) {
        // Handle the failure case here
      },
      (userIdValue) {
        userId = userIdValue;
      },
    );
    tokenData.fold(
      (failure) {
        // Handle the failure case here
      },
      (tokenValue) {
        token = tokenValue;
      },
    );
    try {
      Response response = await dio.delete(
        "${ApiEndpoints.removeLikedPet}/$userId/$petId",
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
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
