import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

class PetState {
  final bool isLoading;
  final String? error;
  final List<PetEntity> pets;

  const PetState({
    required this.isLoading,
    required this.error,
    required this.pets,
  });

  factory PetState.initial() => const PetState(
        isLoading: false,
        error: null,
        pets: [],
      );

  PetState copyWith({
    bool? isLoading,
    String? error,
    List<PetEntity>? pets,
  }) {
    return PetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      pets: pets ?? this.pets,
    );
  }

  PetState updatePets(List<PetEntity> newPets) {
    return copyWith(pets: newPets);
  }
}
