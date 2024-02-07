import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/pets/data/repository/pets_remote_repo_impl.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

final petRepositoryProvider = Provider<IPetRepository>(
  (ref) {
    return ref.read(petRemoteRepositoryProvider);

    // // Check for the internet
    // final internetStatus = ref.watch(connectivityStatusProvider);

    // if (ConnectivityStatus.isConnected == internetStatus) {
    //   print("Internet ACCESS");
    //   return ref.watch(petRemoteRepositoryProvider);
    // } else {
    //   print("NO Internet ACCESS");
    //   // If internet is not available then return local repo
    //   return ref.watch(petLocalRepoProvider);
    // }
  },
);

abstract class IPetRepository {
  Future<Either<Failure, Response>> getAllPets();
  Future<Either<Failure, bool>> addPet(PetEntity pet, File file);
  Future<Either<Failure, Response>> deletePet(String petId);
}
