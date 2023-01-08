import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';

import '../../blocs/bloc.dart';

import '../../constants/nav_bar_items.dart';
import '../../constants/text.dart';
import '../CurrentRide/current_ride.dart';
import '../home/book_ride_screen.dart';
import '../wallet/wallet_screen.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            selectedLabelStyle: navTextStyle(),
            unselectedLabelStyle: navTextStyle(color: const Color(0xFFA5A5A5)),
            selectedItemColor: Colors.black,
            unselectedItemColor: const Color(0xFFA5A5A5),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on_outlined,
                  size: 30,
                ),
                label: 'Current Ride',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.wallet_outlined,
                  size: 30,
                ),
                label: 'Wallet',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                context.read<NavigationCubit>().getNavBarItem(NavBarItem.home);
              }
              if (index == 1) {
                context
                    .read<NavigationCubit>()
                    .getNavBarItem(NavBarItem.currentRide);
              }
              if (index == 2) {
                context
                    .read<NavigationCubit>()
                    .getNavBarItem(NavBarItem.wallet);
              }
            },
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state.navbarItem == NavBarItem.home) {
            return MainScreen();
          }
          if (state.navbarItem == NavBarItem.currentRide) {
            return const CurrentRideScreen();
          }
          if (state.navbarItem == NavBarItem.wallet) {
            return const WalletScreen();
          }
          return Container();
        },
      ),
    );
  }
}
