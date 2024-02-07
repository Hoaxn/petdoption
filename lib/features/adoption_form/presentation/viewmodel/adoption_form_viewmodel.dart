import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/common/snackbar/my_snackbar.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/usecase/adoption_form_usecase.dart';
import 'package:pet_adoption_app/features/adoption_form/presentation/state/adoption_form_state.dart';

final adoptionFormViewModelProvider =
    StateNotifierProvider<AdoptionFormViewModel, AdoptionFormState>(
  (ref) => AdoptionFormViewModel(
    ref.read(adoptionFormUseCaseProvider),
  ),
);

class AdoptionFormViewModel extends StateNotifier<AdoptionFormState> {
  final AdoptionFormUseCase adoptionFormUseCase;

  AdoptionFormViewModel(this.adoptionFormUseCase)
      : super(AdoptionFormState.initial()) {
    getAdoptionForm();
  }

  Future<void> getAdoptionForm() async {
    state = state.copyWith(isLoading: true);
    var data = await adoptionFormUseCase.getAdoptionForm();
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
        final List<AdoptionFormEntity> petAdoptiopnFormEntity = [];

        if (success.data != null && success.data.containsKey('adoptions')) {
          final List<dynamic> items = success.data['adoptions'];

          petAdoptiopnFormEntity.addAll(
            items.map<AdoptionFormEntity>(
              (item) => AdoptionFormEntity(
                petId: item['pet'],
                fullName: item['fullName'],
                phone: item['phone'].toString(),
                email: item['email'],
                address: item['address'],
                // userId: item['user'],
              ),
            ),
          );
        }
        state = state.copyWith(
          isLoading: false,
          error: null,
          petAdoptionFormEntity: petAdoptiopnFormEntity,
        );
      },
    );
  }

  Future<void> postAdoptionForm(
    BuildContext context,
    AdoptionFormEntity pet,
    Function resetFields,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await adoptionFormUseCase.adoptPet(pet);
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
        showSnackBar(
          message: "Pet Adoption Successful !",
          context: context,
          color: Colors.green,
        );
        resetFields();

        // Call the resetFields function to reset the input fields
        resetFields();

        // Navigator.pushNamed(context, AppRoute.homeRoute);
      },
    );
  }

  Future<void> deleteAdoptionForm(BuildContext context, String? petId) async {
    state = state.copyWith(isLoading: true);
    var data = await adoptionFormUseCase.deleteAdoptionForm(petId);
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
          message: "Form Deleted Successfully !",
          context: context,
          color: Colors.green,
        );
        await getAdoptionForm();

        // Navigator.pushNamed(context, AppRoute.homeRoute);
      },
    );
  }
}
