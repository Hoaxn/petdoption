import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/liked_pets/data/repository/liked_pet_remote_repo_impl.dart';

final likedPetRepositoryProvider = Provider<ILikedPetRepository>(
  (ref) => ref.read(likedPetRemoteRepositoryProvider),
);

abstract class ILikedPetRepository {
  Future<Either<Failure, bool>> saveLikedPet(String? petId);
  Future<Either<Failure, Response>> removeLikedPet(String? petId);
  Future<Either<Failure, Response>> getLikedPets();
}
