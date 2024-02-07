import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/adoption_form/data/repository/adoption_form_remote_repo_impl.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';

final adoptionFormRepositoryProvider = Provider<IAdoptionFormRepository>(
  (ref) => ref.read(adoptionFormRemoteRepositoryProvider),
);

abstract class IAdoptionFormRepository {
  Future<Either<Failure, Response>> getAdoptionForm();

  Future<Either<Failure, bool>> postAdoptionForm(
      AdoptionFormEntity adoptFormData);

  Future<Either<Failure, Response>> deleteAdoptionForm(String? petId);
}
