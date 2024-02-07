import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/core/network/local/hive_service.dart';
import 'package:pet_adoption_app/features/auth/data/model/auth_hive_model.dart';
import 'package:pet_adoption_app/features/auth/domain/entity/user_entity.dart';

final authLocalDataSourceProvider = Provider(
  (ref) => AuthLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(authHiveModelProvider),
  ),
);

class AuthLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _authHiveModel;

  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      await _hiveService.addUser(
        _authHiveModel.toHiveModel(user),
      );
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      AuthHiveModel? users = await _hiveService.login(email, password);
      if (users == null) {
        return Left(
          Failure(error: 'Email or password is wrong'),
        );
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }
}
