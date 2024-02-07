import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/common/snackbar/my_snackbar.dart';
import 'package:pet_adoption_app/features/liked_pets/domain/usecase/liked_pet_usecase.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';
import 'package:pet_adoption_app/features/pets/presentation/state/pet_state.dart';

final likedPetViewModelProvider =
    StateNotifierProvider<LikedPetViewModel, PetState>(
  (ref) => LikedPetViewModel(
    ref.read(likedPetUseCaseProvider),
  ),
);

class LikedPetViewModel extends StateNotifier<PetState> {
  final LikedPetUseCase likedPetUseCase;

  LikedPetViewModel(this.likedPetUseCase) : super(PetState.initial()) {
    getLikedPets();
  }

  Future<void> getLikedPets() async {
    state = state.copyWith(isLoading: true);
    var data = await likedPetUseCase.getLikedPets();
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        // showSnackBar(
        //     message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        final List<PetEntity> pets = [];

        if (success.data != null && success.data.containsKey('likedPets')) {
          final List<dynamic> items = success.data['likedPets'];

          pets.addAll(
            items.map<PetEntity>(
              (item) => PetEntity(
                petId: item['pet']['_id'],
                name: item['pet']['name'],
                age: item['pet']['age'].toString(),
                species: item['pet']['species'],
                breed: item['pet']['breed'],
                gender: item['pet']['gender'],
                description: item['pet']['description'],
                color: item['pet']['color'],
                image: item['pet']['image'],
                // userId: item['user'],
              ),
            ),
          );
        }
        state = state.copyWith(
          isLoading: false,
          error: null,
          pets: pets,
        );
      },
    );
  }

  Future<void> saveLikedPet(
    BuildContext context,
    String? petId,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await likedPetUseCase.saveLikedPet(petId);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
        // showSnackBar(
        //   message: "Pet Liked Successful !",
        //   context: context,
        //   color: Colors.green,
        // );
      },
    );
  }

  Future<void> removeLikedPet(BuildContext context, String? petId) async {
    state = state.copyWith(isLoading: true);
    var data = await likedPetUseCase.removeLikedPet(petId);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) async {
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
        // print('success ${success.data}');
        showSnackBar(
          message: "Pet Unliked Successfully !",
          context: context,
          color: Colors.green,
        );
        await getLikedPets();

        // Navigator.pushNamed(context, AppRoute.homeRoute);
      },
    );
  }
}
