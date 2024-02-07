import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/core/common/provider/is_dark_theme.dart';
import 'package:pet_adoption_app/features/home/presentation/viewmodel/home_viewmodel.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  late bool isDark;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    isDark = ref.read(isDarkThemeProvider);

    const gap = SizedBox(height: 10);

    return Drawer(
      width: deviceWidth * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(color: ThemeConstant.secondaryColor),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    },
                    icon: const Icon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          gap,
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(FontAwesomeIcons.paw),
                ),
                const SizedBox(width: 16.0),
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          gap,
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoute.addPetRoute);
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(FontAwesomeIcons.plus),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Add Pet",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          gap,
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoute.likedPetRoute);
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(FontAwesomeIcons.solidHeart),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Favorites",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          gap,
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoute.getAllAdoptionFormRoute);
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(FontAwesomeIcons.scroll),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Adoption Form",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          gap,
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.dark_mode),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Row(
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      setState(
                        () {
                          isDark = value;
                          ref
                              .read(isDarkThemeProvider.notifier)
                              .updateTheme(value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          gap,
          InkWell(
            onTap: () async {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            // onTap: () async {
            //   // Handle drawer item tap for Analytics

            //   final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
            //     return UserSharedPrefs();
            //   });

            //   // Inside the class or widget where you want to perform logout
            //   final userSharedPrefs = ref.read(userSharedPrefsProvider);
            //   final result = await userSharedPrefs.removeUserToken();
            //   result.fold(
            //     (failure) {
            //       // Handle the failure, e.g., display an error message
            //       print('Failed to remove token: ${failure.error}');
            //     },
            //     (success) {
            //       print('Token removed successfully');
            //       Navigator.pushNamed(context, AppRoute.loginRoute);
            //     },
            //   );
            // },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    FontAwesomeIcons.rightFromBracket,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
