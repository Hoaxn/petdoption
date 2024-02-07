import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';

class AdoptionFormState {
  final bool isLoading;
  final String? error;
  final List<AdoptionFormEntity> petAdoptionFormEntity;

  const AdoptionFormState({
    required this.isLoading,
    required this.error,
    required this.petAdoptionFormEntity,
  });

  factory AdoptionFormState.initial() => const AdoptionFormState(
        isLoading: false,
        error: null,
        petAdoptionFormEntity: [],
      );

  AdoptionFormState copyWith({
    bool? isLoading,
    String? error,
    List<AdoptionFormEntity>? petAdoptionFormEntity,
  }) {
    return AdoptionFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      petAdoptionFormEntity:
          petAdoptionFormEntity ?? this.petAdoptionFormEntity,
    );
  }

  AdoptionFormState updateAdoptionForm(
      List<AdoptionFormEntity> newPetAdoptionFormEntity) {
    return copyWith(petAdoptionFormEntity: newPetAdoptionFormEntity);
  }
}
