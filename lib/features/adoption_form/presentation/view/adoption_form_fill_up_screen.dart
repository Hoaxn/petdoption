import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/config/constants/api_endpoint.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';
import 'package:pet_adoption_app/core/common/widget/primary_button.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';
import 'package:pet_adoption_app/features/adoption_form/presentation/viewmodel/adoption_form_viewmodel.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

class AdoptionFormFillUpScreen extends ConsumerStatefulWidget {
  final PetEntity pet;

  const AdoptionFormFillUpScreen({Key? key, required this.pet})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdoptionFormFillUpScreenState();
}

class _AdoptionFormFillUpScreenState
    extends ConsumerState<AdoptionFormFillUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _resetFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // final internetStatus = ref.watch(connectivityStatusProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          // color: Theme.of(context).primaryColor,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "Adoption Form",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          // color: Theme.of(context).primaryColor,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "a",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                          // color: Theme.of(context).primaryColor,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    // color: Theme.of(context).primaryColor.withOpacity(0.07),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.07),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "${widget.pet.name}'s Info:",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              // color: Theme.of(context).primaryColor,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Age: ${widget.pet.age}",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                            // color: Theme.of(context).primaryColor,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Species: ${widget.pet.species}",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                            // color: Theme.of(context).primaryColor,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Breed: ${widget.pet.breed}",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                            // color: Theme.of(context).primaryColor,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Gender: ${widget.pet.gender}",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                            // color: Theme.of(context).primaryColor,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Description: ${widget.pet.description}",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                            // color: Theme.of(context).primaryColor,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        AspectRatio(
                            aspectRatio: 16 / 10,
                            child: Image.network(
                              // "http://192.168.1.67:3000/uploads/${widget.pet.image}",
                              // "http://localhost:3000/uploads/${widget.pet.image}",
                              ApiEndpoints.baseImageUrl(widget.pet.image),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    // color: Theme.of(context).primaryColor.withOpacity(0.07),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.07),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              // 'Adopt ${widget.pet.name}',
                              "Form",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                // color: Theme.of(context).primaryColor,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Adopter\'s Full Name',
                              hintStyle: TextStyle(
                                // color: Theme.of(context).primaryColor,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: ThemeConstant.secondaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Adopter\'s Email',
                              hintStyle: TextStyle(
                                // color: Theme.of(context).primaryColor,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: ThemeConstant.secondaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'Adopter\'s Phone',
                              hintStyle: TextStyle(
                                // color: Theme.of(context).primaryColor,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: ThemeConstant.secondaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: 'Adopter\'s Address',
                              hintStyle: TextStyle(
                                // color: Theme.of(context).primaryColor,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: ThemeConstant.secondaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            maxLines: 3,
                          ),
                          const SizedBox(height: 24.0),
                          PrimaryButton(
                            text: 'Adopt ${widget.pet.name}',
                            isLoading: ref
                                .watch(adoptionFormViewModelProvider)
                                .isLoading,
                            buttonHeight: size.height * 0.050,
                            borderRadius: BorderRadius.circular(10),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String fullName = nameController.text;
                                String email = emailController.text;
                                String phone = phoneController.text;
                                String address = addressController.text;
                                String petId = widget.pet.petId ?? '';

                                AdoptionFormEntity currentPet =
                                    AdoptionFormEntity(
                                  fullName: fullName,
                                  email: email,
                                  address: address,
                                  phone: phone,
                                  petId: petId,
                                );
                                await ref
                                    .read(
                                        adoptionFormViewModelProvider.notifier)
                                    .postAdoptionForm(
                                      context,
                                      currentPet,
                                      _resetFields,
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
