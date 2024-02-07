import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/config/constants/api_endpoint.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/core/network/remote/http_service.dart';
import 'package:pet_adoption_app/core/shared_pref/user_shared_pref.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';

final adoptionFormRemoteDataSourceProvider =
    Provider<AdoptionFormRemoteDataSource>(
  (ref) {
    return AdoptionFormRemoteDataSource(
      ref.read(httpServiceProvider),
      ref.read(userSharedPrefsProvider),
      // ref.read(petApiModelProvider),
    );
  },
);

class AdoptionFormRemoteDataSource {
  final Dio dio;
  // final PetApiModel petApiModel;
  final UserSharedPrefs userSharedPrefs;

  AdoptionFormRemoteDataSource(this.dio, this.userSharedPrefs);

  Future<Either<Failure, Response>> getAdoptionForm() async {
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
        "${ApiEndpoints.getAdoptionFormsByUserId}/$userId",
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

  Future<Either<Failure, bool>> postAdoptionForm(
      AdoptionFormEntity adoptFormData) async {
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
      Response response = await dio.post(
        ApiEndpoints.postAdoptionForm,
        data: {
          "fullName": adoptFormData.fullName,
          "email": adoptFormData.email,
          "phone": adoptFormData.phone,
          "address": adoptFormData.address,
          "petId": adoptFormData.petId,
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

  Future<Either<Failure, Response>> deleteAdoptionForm(String? petId) async {
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
        "${ApiEndpoints.deleteAdoptionForm}/$userId/$petId",
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
