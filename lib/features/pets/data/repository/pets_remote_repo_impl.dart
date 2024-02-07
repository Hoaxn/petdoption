import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/pets/data/data_source/pets_remote_data_source.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';
import 'package:pet_adoption_app/features/pets/domain/repository/pets_repository.dart';

final petRemoteRepositoryProvider = Provider<IPetRepository>(
  (ref) => PetRemoteRepositoryImpl(
    petRemoteDataSource: ref.read(petRemoteDataSourceProvider),
  ),
);

class PetRemoteRepositoryImpl implements IPetRepository {
  final PetRemoteDataSource petRemoteDataSource;

  PetRemoteRepositoryImpl({required this.petRemoteDataSource});

  @override
  Future<Either<Failure, Response>> getAllPets() {
    return petRemoteDataSource.getAllPets();
  }

  @override
  Future<Either<Failure, bool>> addPet(PetEntity pet, File file) {
    return petRemoteDataSource.addPet(pet, file);
  }

  @override
  Future<Either<Failure, Response>> deletePet(String petId) {
    return petRemoteDataSource.deletePet(petId);
  }
}
