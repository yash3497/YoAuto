import 'package:auto/screens/CurrentRide/current_ride.dart';
import 'package:auto/screens/home/home_screen.dart';
import 'package:auto/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc.dart';
import 'package:auto/constants/constant.dart';

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
            return const HomeScreen();
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
