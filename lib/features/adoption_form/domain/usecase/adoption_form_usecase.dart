import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/repository/adoption_form_repository.dart';

final adoptionFormUseCaseProvider = Provider<AdoptionFormUseCase>(
  (ref) => AdoptionFormUseCase(
    adoptionFormRepository: ref.read(adoptionFormRepositoryProvider),
  ),
);

class AdoptionFormUseCase {
  final IAdoptionFormRepository adoptionFormRepository;

  AdoptionFormUseCase({required this.adoptionFormRepository});

  Future<Either<Failure, Response>> getAdoptionForm() {
    return adoptionFormRepository.getAdoptionForm();
  }

  Future<Either<Failure, bool>> adoptPet(
      AdoptionFormEntity adoptFormData) async {
    return adoptionFormRepository.postAdoptionForm(adoptFormData);
  }

  Future<Either<Failure, Response>> deleteAdoptionForm(String? petId) async {
    return await adoptionFormRepository.deleteAdoptionForm(petId);
  }
}
