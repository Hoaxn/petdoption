import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/adoption_form/data/data_source/adoption_form_remote_data_source.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/repository/adoption_form_repository.dart';

final adoptionFormRemoteRepositoryProvider = Provider<IAdoptionFormRepository>(
  (ref) => AdoptionFormRemoteRepositoryImpl(
    adoptionFormRemoteDataSource:
        ref.read(adoptionFormRemoteDataSourceProvider),
  ),
);

class AdoptionFormRemoteRepositoryImpl implements IAdoptionFormRepository {
  final AdoptionFormRemoteDataSource adoptionFormRemoteDataSource;

  AdoptionFormRemoteRepositoryImpl(
      {required this.adoptionFormRemoteDataSource});

  @override
  Future<Either<Failure, Response>> getAdoptionForm() {
    return adoptionFormRemoteDataSource.getAdoptionForm();
  }

  @override
  Future<Either<Failure, bool>> postAdoptionForm(
      AdoptionFormEntity adoptFormData) {
    return adoptionFormRemoteDataSource.postAdoptionForm(adoptFormData);
  }

  @override
  Future<Either<Failure, Response>> deleteAdoptionForm(String? petId) {
    return adoptionFormRemoteDataSource.deleteAdoptionForm(petId);
  }
}
