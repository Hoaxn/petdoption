import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_adoption_app/config/constants/api_endpoint.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/core/common/widget/primary_button.dart';
import 'package:pet_adoption_app/features/adoption_form/presentation/view/adoption_form_fill_up_screen.dart';
import 'package:pet_adoption_app/features/liked_pets/presentation/viewmodel/liked_pet_viewmodel.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';

class AdoptionScreen extends ConsumerStatefulWidget {
  final PetEntity pet;

  const AdoptionScreen({super.key, required this.pet});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends ConsumerState<AdoptionScreen> {
  void goBackToHomeScreen() {
    Navigator.popUntil(
      context,
      ModalRoute.withName(AppRoute.homeRoute),
    );
  }

  Future<bool> onLikeButtonTap(bool isLiked) async {
    if (isLiked) {
      await ref
          .read(likedPetViewModelProvider.notifier)
          .removeLikedPet(context, widget.pet.petId);
    } else {
      await ref
          .read(likedPetViewModelProvider.notifier)
          .saveLikedPet(context, widget.pet.petId);
    }
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    // final internetStatus = ref.watch(connectivityStatusProvider);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: screenHeight * 0.5,
                    // width: screenWidth * 1,
                    color:
                        widget.pet.color != null && widget.pet.color!.isNotEmpty
                            ? Color(
                                int.parse(
                                  '0xFF${widget.pet.color?.substring(0)}',
                                ),
                              )
                            : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
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
                              // Icon(
                              //   FontAwesomeIcons.share,
                              //   // color: Theme.of(context).primaryColor,
                              //   color: Theme.of(context).colorScheme.primary,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.30,
                    // width: screenWidth * 1.0,
                    child: Hero(
                        tag: widget.pet.petId!,
                        child: Image.network(
                          // "http://192.168.1.67:3000/uploads/${widget.pet.image}",
                          // "http://localhost:3000/uploads/${widget.pet.image}",
                          ApiEndpoints.baseImageUrl(widget.pet.image),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                ],
              ),

              // Mid Description Part start
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            // backgroundColor: Theme.of(context).primaryColor,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            backgroundImage:
                                const AssetImage('assets/images/apple.png'),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "PetDoption",
                                    style: TextStyle(
                                      // color: Theme.of(context).primaryColor,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const Text(
                                  //   "Jan 01, 2023",
                                  //   style: TextStyle(
                                  //     color: Colors.grey,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                "Owner",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        // height: 20.0,
                        height: screenHeight * 0.0212,
                      ),
                      Text(
                        widget.pet.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Mid Description Part start

              // End Like and Adopt Me ! part start
              Container(
                // height: 150,
                height: screenHeight * 0.155,
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor.withOpacity(0.07),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.07),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LikeButton(
                          onTap: onLikeButtonTap,
                        ),
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Expanded(
                        child: PrimaryButton(
                          text: "Adopt ${widget.pet.name}",
                          isLoading: false,
                          borderRadius: BorderRadius.circular(20.0),
                          buttonHeight: size.height * 0.070,
                          boxShadow: const [],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdoptionFormFillUpScreen(pet: widget.pet),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // End Like and Adopt Me ! part end
            ],
          ),

          // Hovering Part start
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                // height: 140.0,
                height: screenHeight * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.pet.name,
                          style: TextStyle(
                            fontSize: 26.0,
                            // color: Theme.of(context).primaryColor,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          widget.pet.gender == 'female'
                              ? FontAwesomeIcons.venus
                              : FontAwesomeIcons.mars,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.pet.breed,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${widget.pet.age} years old",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.locationDot,
                          // color: Theme.of(context).primaryColor,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Kathmandu, Nepal",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Hovering part end
        ],
      ),
    );
  }
}
