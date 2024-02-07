// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pet_adoption_app/core/failure/failure.dart';
// import 'package:pet_adoption_app/core/network/local/hive_service.dart';
// import 'package:pet_adoption_app/features/pets/data/model/pet_hive_model.dart';
// import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

// final petLocalDataSourceProvider = Provider<PetLocalDataSource>((ref) {
//   return PetLocalDataSource(
//     hiveService: ref.read(hiveServiceProvider),
//     petHiveModel: ref.read(petHiveModelProvider),
//   );
// });

// class PetLocalDataSource {
//   final HiveService hiveService;
//   final PetHiveModel petHiveModel;

//   PetLocalDataSource({
//     required this.hiveService,
//     required this.petHiveModel,
//   });

//   // Add Pet
//   Future<Either<Failure, bool>> addPet(PetEntity pet) async {
//     try {
//       // Convert Entity to Hive Object
//       final hivePet = petHiveModel.toHiveModel(pet);

//       // Add to Hive
//       await hiveService.addPet(hivePet);

//       return const Right(true);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }

//   Future<Either<Failure, List<PetEntity>>> getAllPets() async {
//     try {
//       // Get all pets from Hive
//       final pets = await hiveService.getAllPets();

//       // Convert Hive Object to Entity
//       final petEntities = petHiveModel.toEntityList(pets);

//       return Right(petEntities);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/core/network/local/hive_service.dart';

class PetLocalDataSource {
  final HiveService hiveService;

  PetLocalDataSource({
    required this.hiveService,
  });

  Future<dynamic> retrieveDataFromHive() async {
    try {
      final box = await Hive.openBox("hivePets");
      final hiveDashboardData = box.get('1');
      await box.close();
      return hiveDashboardData;
    } catch (e) {
      print('Error while retrieving data from Hive: $e');
    }
  }

  Future<Either<Failure, bool>> storePetDataInHive(List<dynamic> pets) async {
    try {
      final box = await Hive.openBox("hivePets");
      box.clear();

      await box.put('2', pets);
      print('Saved Pet Data To Hive Database');

      await box.close(); // Move this line outside the loop

      return const Right(true);
    } catch (e) {
      print('error is coming $e');
      return Left(Failure(error: e.toString()));
    }
  }
}
