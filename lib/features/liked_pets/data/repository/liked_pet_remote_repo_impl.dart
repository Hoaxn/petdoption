import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/liked_pets/data/data_source/liked_pet_remote_data_source.dart';
import 'package:pet_adoption_app/features/liked_pets/domain/repository/liked_pet_repository.dart';

final likedPetRemoteRepositoryProvider = Provider<ILikedPetRepository>(
  (ref) => LikedPetRemoteRepositoryImpl(
    likedPetRemoteDataSource: ref.read(likedPetRemoteDataSourceProvider),
  ),
);

class LikedPetRemoteRepositoryImpl implements ILikedPetRepository {
  final LikedPetRemoteDataSource likedPetRemoteDataSource;

  LikedPetRemoteRepositoryImpl({required this.likedPetRemoteDataSource});

  @override
  Future<Either<Failure, bool>> saveLikedPet(String? petId) {
    return likedPetRemoteDataSource.saveLikedPet(petId);
  }

  @override
  Future<Either<Failure, Response>> removeLikedPet(String? petId) {
    return likedPetRemoteDataSource.removeLikedPet(petId);
  }

  @override
  Future<Either<Failure, Response>> getLikedPets() {
    return likedPetRemoteDataSource.getLikedPets();
  }
}
