import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';
import 'package:pet_adoption_app/core/common/widget/drawer_widget.dart';
import 'package:pet_adoption_app/features/adoption_form/domain/entity/adoption_form_entity.dart';
import 'package:pet_adoption_app/features/adoption_form/presentation/viewmodel/adoption_form_viewmodel.dart';

class GetAllAdoptionFormScreen extends ConsumerStatefulWidget {
  const GetAllAdoptionFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GetAllAdoptionFormScreenState();
}

class _GetAllAdoptionFormScreenState
    extends ConsumerState<GetAllAdoptionFormScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Future<void> _handleRefresh() async {
    final adoptionFormViewModel =
        ref.read(adoptionFormViewModelProvider.notifier);
    await adoptionFormViewModel.getAdoptionForm();

    // await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    // Delay the call using Future.microtask to ensure it runs after the widget tree is built
    Future.microtask(
      () {
        _handleRefresh(); // Trigger data refresh when the widget is first created
      },
    );
  }

  Future<bool> showConfirmationDialog(
    BuildContext context,
    AdoptionFormEntity adoptionForm,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text('Confirm Delete'),
              content: const Text('Are you sure you want to delete this form?'),
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

  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;

    final adoptionFormState = ref.watch(adoptionFormViewModelProvider);

    // final internetStatus = ref.watch(connectivityStatusProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        height: 250,
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
                            "Adoption Form",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                              // color: Theme.of(context).primaryColor,
                              color: Theme.of(context).colorScheme.primary,
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
                      ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 25.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11.0,
                            ),
                          ),
                        ),
                        if (adoptionFormState.isLoading) ...{
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        } else if (adoptionFormState
                            .petAdoptionFormEntity.isEmpty) ...{
                          Center(
                            child: Text(
                              "No Adoption Form",
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
                            itemCount:
                                adoptionFormState.petAdoptionFormEntity.length,
                            itemBuilder: (content, index) {
                              final adoptionForm = adoptionFormState
                                  .petAdoptionFormEntity[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(30.0),
                                      elevation: 5.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 12.0,
                                        ),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
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
                                                      Flexible(
                                                        child: Text(
                                                          adoptionForm.fullName,
                                                          style: TextStyle(
                                                            fontSize: 24.0,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      PopupMenuButton<String>(
                                                        onSelected:
                                                            (value) async {
                                                          // Handle action selection
                                                          if (value ==
                                                              'delete') {
                                                            // Show confirmation dialog for delete action
                                                            bool confirmDelete =
                                                                await showConfirmationDialog(
                                                              context,
                                                              adoptionForm,
                                                            );
                                                            if (confirmDelete) {
                                                              // Handle delete action
                                                              final adoptionFormViewModel =
                                                                  ref.read(
                                                                adoptionFormViewModelProvider
                                                                    .notifier,
                                                              );
                                                              await adoptionFormViewModel
                                                                  .deleteAdoptionForm(
                                                                context,
                                                                adoptionForm
                                                                    .petId,
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
                                                              value: 'delete',
                                                              child: Text(
                                                                'Delete',
                                                              ),
                                                            ),
                                                          ];
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    adoptionForm.email,
                                                    style: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    adoptionForm.phone,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    adoptionForm.address,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    adoptionForm.petId,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
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
                                  ],
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
