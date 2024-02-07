// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pet_adoption_app/core/failure/failure.dart';
// import 'package:pet_adoption_app/features/pets/data/data_source/pets_local_data_source.dart';
// import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';
// import 'package:pet_adoption_app/features/pets/domain/repository/pets_repository.dart';

// final petLocalRepoProvider = Provider<IPetRepository>((ref) {
//   return PetLocalRepositoryImpl(
//     petLocalDataSource: ref.read(petLocalDataSourceProvider),
//   );
// });

// class PetLocalRepositoryImpl implements IPetRepository {
//   final PetLocalDataSource petLocalDataSource;

//   PetLocalRepositoryImpl({
//     required this.petLocalDataSource,
//   });

//   @override
//   Future<Either<Failure, List<PetEntity>>> getAllPets() {
//     return petLocalDataSource.getAllPets();
//   }

//   @override
//   Future<Either<Failure, bool>> addPet(PetEntity pet, File file) {
//     return petLocalDataSource.addPet(pet);
//   }

//   @override
//   Future<Either<Failure, Response>> deletePet(String petId) {
//     // TODO: implement removeBookmark
//     throw UnimplementedError();
//   }
// }
