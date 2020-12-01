import 'dart:developer';

import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:cuaderno_pedagogico/model/provider/navigation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// In the Widget Tab there are the Home,
/// Categories, Post, Messages, Profile screens,
/// each with independent Navigation. It is managed by
/// [NavigationProvider]
class Tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// consume  to NavigationProvider
    /// [WillPopScope] manages Navigator.pop of each tab
    ///
    /// bottomNavigationBar uses a custom Widget called
    /// [_PetAppNavigationBar], which contains Home, Categories,
    /// Messages, Profile.
    ///
    /// CreatePost is in Scaffold's floatingActionButton,
    /// so that it is in the center of the tab, using the
    /// [FloatingActionButtonLocation.centerDocked] property.
    ///
    /// The CreatePost and Profile screens go through a
    /// verification if the user is logged in, in case of True they
    /// will be able to enter those screens
    ///
    return Consumer<NavigationProvider>(builder: (context, provider, _) {
      final screens = provider.screens
          .map((screen) => TickerMode(
                enabled: screen == provider.currentScreen,
                child: Offstage(
                  offstage: screen != provider.currentScreen,
                  child: Navigator(
                    // initialRoute: screen.initialRoute,
                    key: screen.navigatorState,
                    onGenerateRoute: screen.onGenerateRoute,
                  ),
                ),
              ))
          .toList();

      return WillPopScope(
        onWillPop: provider.onWillPop,
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: _PetAppNavigationBar(
              currentIndex: provider.currentTabIndex,
              onIndexSelected: (index) {
                provider.setTab(index);
              },
            ),
            floatingActionButton: GestureDetector(
              onTap: () {
                provider.setTab(1);
              },
              child: Container(
                height: 65,
                width: 65,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 65),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  width: 33,
                  height: 33,
                  child: Icon(
                    CupertinoIcons.list_number,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: IndexedStack(
                    children: screens,
                    index: provider.currentTabIndex,
                  ),
                ),
              ],
            )),
      );
    });
  }
}
// Positioned(
//   right: 0,
//   left: 0,
//   bottom: 0,
//   child: _PetAppNavigationBar(
//     currentIndex: provider.currentTabIndex,
//     onIndexSelected: (index) {
//       provider.setTab(index);
//     },
//     screens: provider.screens,
//   ),
// )

/// Custom widget for the NavigationBar.
class _PetAppNavigationBar extends StatelessWidget {
  /// currentIndex currentIndex, variable that determines
  /// which tab the user is in, will be used to paint the Tab control

  final int currentIndex;

  /// onIndexSelected, captures the tab pressed by the user.
  /// The CreatePost and Profile screens go through a
  /// verification if the user is logged in, in case of True they
  /// will be able to enter those screens
  ///
  final ValueChanged<int> onIndexSelected;

  _PetAppNavigationBar({Key key, this.currentIndex, this.onIndexSelected})
      : super(key: key);

  Widget _buildItem(
          {String label, IconData icon, int index, VoidCallback onTap}) =>
      Expanded(
          child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 2),
                  child: Column(
                    children: [
                      Container(
                        height: 23,
                        width: 23,
                        color: Colors.transparent,
                        child: Icon(
                          icon,
                          color: currentIndex == index
                              ? AppColors.green
                              : AppColors.iconLabelColor,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        label,
                        style: TextStyle(
                            fontSize: 10,
                            color: currentIndex == index
                                ? AppColors.green
                                : AppColors.iconLabelColor),
                      )
                    ],
                  ),
                ),
              )));
  @override
  Widget build(BuildContext context) {
    return Container(

        // decoration: BoxDecoration(color: Colors.blue, boxShadow: []),
        height: 65 + MediaQuery.of(context).padding.bottom,
        child: Stack(children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, -2))
              ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildItem(
                      label: 'Funciones',
                      icon: CupertinoIcons.square_stack_3d_up,
                      index: 0,
                      onTap: () => onIndexSelected(0)),
                  Expanded(
                      child: SizedBox(
                    width: 65,
                  )),
                  _buildItem(
                      label: 'Utilitarios',
                      icon: CupertinoIcons.pencil_circle,
                      index: 2,
                      onTap: () => onIndexSelected(2)),
                ],
              ),
            ),
          ),
          // Align(
          //     alignment: Alignment.topCenter,
          //     child: GestureDetector(
          //       onTap: () {
          //         final user = UserProvider.of(context).user;
          //         if (user == null) {
          //           showDialog(
          //               barrierColor: Colors.black.withOpacity(0.3),
          //               context: context,
          //               useRootNavigator: true,
          //               builder: (context) => CustomLoginDialog(
          //                     toTab: 2,
          //                   ));
          //         } else {
          //           onIndexSelected(2);
          //         }
          //       },
          //       child: Container(
          //         height: 65,
          //         width: 65,
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.white, width: 3),
          //             color: PetAppColors.green,
          //             borderRadius: BorderRadius.circular(50)),
          //         // child: ,
          //       ),
          //     )),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).padding.bottom,
              color: Colors.white,
            ),
          ),
        ]));
  }
}
