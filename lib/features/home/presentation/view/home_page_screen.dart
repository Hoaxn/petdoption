import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_adoption_app/config/constants/api_endpoint.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/core/common/provider/is_dark_theme.dart';
import 'package:pet_adoption_app/core/common/widget/drawer_widget.dart';
import 'package:pet_adoption_app/core/utils/sensor_utils.dart';
import 'package:pet_adoption_app/features/home/data/model/home_page_model.dart';
import 'package:pet_adoption_app/features/home/presentation/view/adoption_screen.dart';
import 'package:pet_adoption_app/features/pets/domain/entity/pet_entity.dart';
import 'package:pet_adoption_app/features/pets/presentation/viewmodel/pet_viewmodel.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  int selectedAnimalIconIndex = 0;

  List<PetEntity> filteredPets = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Delay the call using Future.microtask to ensure it runs after the widget tree is built
  //   Future.microtask(
  //     () {
  //       _handleRefresh(); // Trigger data refresh when the widget is first created
  //     },
  //   );
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.microtask(
      () {
        _handleRefresh(); // Trigger data refresh when the widget is first created
      },
    );

    // Filter pets with species "dog" when the app is opened
    filterPetsBySpecies("dog");
  }

  @override
  void initState() {
    super.initState();
    SensorUtils.listen();
    SensorUtils.accelerometer(
      fun: () {
        final isDark = ref.read(isDarkThemeProvider);
        ref.read(isDarkThemeProvider.notifier).updateTheme(!isDark);
      },
    );
  }

  void filterPetsBySpecies(String species) {
    // print("Filtering by species: $species");
    setState(
      () {
        final petState = ref.watch(petViewModelProvider);
        filteredPets = petState.pets
            .where(
              (pet) => pet.species.toLowerCase().contains(
                    species.toLowerCase(),
                  ),
            )
            .toList();
        // print("Filtered pets count: ${filteredPets.length}");
      },
    );
  }

  Widget buildAnimalIcons(int index) {
    final String animalType = animalTypes[index].toLowerCase();
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(
                () {
                  selectedAnimalIconIndex = index;
                  filterPetsBySpecies(animalType);
                },
              );
            },
            child: Material(
              color: selectedAnimalIconIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              elevation: 6.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  animalIcons[index],
                  size: 30.0,
                  color: selectedAnimalIconIndex == index
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            animalTypes[index],
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    final petViewModel = ref.read(petViewModelProvider.notifier);
    await petViewModel.getAllPets();

    filterPetsBySpecies(animalTypes[selectedAnimalIconIndex].toLowerCase());
    // await Future.delayed(const Duration(seconds: 2));
  }

  Future<bool> showConfirmationDialog(
    BuildContext context,
    PetEntity pet,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 4.0,
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text('Confirm Delete'),
              content: Text('Are you sure you want to delete ${pet.name}?'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog and return false (cancel)
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Close the dialog and return true (confirm)
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false; // If showDialog returns null, consider it as "Cancel".
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final deviceHeight = MediaQuery.of(context).size.height;

    final petState = ref.watch(petViewModelProvider);

    // final internetStatus = ref.watch(connectivityStatusProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        // height: 250,
        height: deviceHeight * 0.25,
        color: ThemeConstant.secondaryColor,
        // animSpeedFactor: 3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: openDrawer,
                        child: const Icon(
                          FontAwesomeIcons.barsStaggered,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.6),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Text(
                                "Kathmandu, ",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600,
                                  // fontFamily: "MerriweatherSans",
                                ),
                              ),
                              const Text(
                                "Nepal",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          'https://www.pexels.com/photo/2486168/download/',
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.07),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 25.0,
                          ),
                          // child: Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 11.0,
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         FontAwesomeIcons.magnifyingGlass,
                          //         color: Colors.grey[500],
                          //       ),
                          //       Expanded(
                          //         child: TextField(
                          //           style: const TextStyle(
                          //             fontSize: 17,
                          //           ),
                          //           decoration: InputDecoration(
                          //             border: const OutlineInputBorder(
                          //               borderSide: BorderSide.none,
                          //             ),
                          //             hintText: "Search ...",
                          //             hintStyle: TextStyle(
                          //               color: Colors.grey[500],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Icon(
                          //         FontAwesomeIcons.filter,
                          //         color: Colors.grey[500],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                        SizedBox(
                          height: 120.0,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 20.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: animalTypes.length,
                            itemBuilder: ((context, index) {
                              return buildAnimalIcons(index);
                            }),
                          ),
                        ),
                        if (petState.isLoading) ...{
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        } else if (petState.pets.isEmpty) ...{
                          Center(
                            child: Text(
                              "No Pets Available",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        } else ...{
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 10.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            // itemCount: petState.pets.length,
                            itemCount: filteredPets.length,
                            itemBuilder: (content, index) {
                              // final pet = petState.pets[index];
                              final pet = filteredPets[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdoptionScreen(
                                        pet: pet,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                    left: 16.0,
                                    right: 16.0,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Material(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        elevation: 5.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20.0,
                                            horizontal: 12.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: deviceWidth * 0.4,
                                                height: deviceHeight * 0.10,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          pet.name,
                                                          style: TextStyle(
                                                            fontSize: 25.0,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                        PopupMenuButton<String>(
                                                          onSelected:
                                                              (value) async {
                                                            // Handle action selection
                                                            if (value ==
                                                                'edit') {
                                                              // Handle edit action
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                AppRoute
                                                                    .addPetRoute,
                                                                arguments: pet,
                                                              );
                                                            } else if (value ==
                                                                'delete') {
                                                              // Show confirmation dialog for delete action
                                                              bool
                                                                  confirmDelete =
                                                                  await showConfirmationDialog(
                                                                context,
                                                                pet,
                                                              );
                                                              if (confirmDelete) {
                                                                // Handle delete action
                                                                final petViewModel =
                                                                    ref.read(
                                                                  petViewModelProvider
                                                                      .notifier,
                                                                );
                                                                await petViewModel
                                                                    .deletePet(
                                                                  context,
                                                                  pet.petId!,
                                                                );
                                                              }
                                                            }
                                                          },
                                                          itemBuilder:
                                                              (BuildContext
                                                                  context) {
                                                            return [
                                                              const PopupMenuItem<
                                                                  String>(
                                                                value: 'edit',
                                                                child: Text(
                                                                  'Edit',
                                                                ),
                                                              ),
                                                              const PopupMenuItem<
                                                                  String>(
                                                                value: 'delete',
                                                                child: Text(
                                                                  'Delete',
                                                                ),
                                                              ),
                                                            ];
                                                          },
                                                        ),
                                                        Icon(
                                                          pet.gender == 'female'
                                                              ? FontAwesomeIcons
                                                                  .venus
                                                              : FontAwesomeIcons
                                                                  .mars,
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      pet.species,
                                                      style: TextStyle(
                                                        fontSize: 19.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      pet.breed,
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      "${pet.age} years old",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: pet.color != null &&
                                                      pet.color!.isNotEmpty
                                                  ? Color(
                                                      int.parse(
                                                        '0xFF${pet.color?.substring(0)}',
                                                      ),
                                                    )
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            height: 200.0,
                                            // height: deviceHeight * 0.21,
                                            width: deviceWidth * 0.4,
                                          ),
                                          Hero(
                                            tag: pet.petId!,
                                            child: Image.network(
                                              // "http://192.168.1.67:3000/uploads/${pet.image}",
                                              // "http://localhost:3000/uploads/${pet.image}",
                                              ApiEndpoints.baseImageUrl(
                                                  pet.image),
                                              height: 220.0,
                                              // height: deviceHeight * 0.236,
                                              // height: deviceHeight * 0.25,
                                              width: deviceWidth * 0.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        },
                      ],
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
