import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/liked_pets/domain/repository/liked_pet_repository.dart';

final likedPetUseCaseProvider = Provider<LikedPetUseCase>(
  (ref) => LikedPetUseCase(
    likedPetRepository: ref.read(likedPetRepositoryProvider),
  ),
);

class LikedPetUseCase {
  final ILikedPetRepository likedPetRepository;

  LikedPetUseCase({required this.likedPetRepository});

  Future<Either<Failure, bool>> saveLikedPet(String? petId) {
    return likedPetRepository.saveLikedPet(petId);
  }

  Future<Either<Failure, Response>> removeLikedPet(String? petId) async {
    return await likedPetRepository.removeLikedPet(petId);
  }

  Future<Either<Failure, Response>> getLikedPets() {
    return likedPetRepository.getLikedPets();
  }
}
