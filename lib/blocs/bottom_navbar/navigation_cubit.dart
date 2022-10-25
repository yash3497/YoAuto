import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import '../../constants/constant.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavBarItem.home, 0));

  void getNavBarItem(NavBarItem navbarItem) {
    switch (navbarItem) {
      case NavBarItem.home:
        emit(NavigationState(NavBarItem.home, 0));
        break;
      case NavBarItem.currentRide:
        emit(NavigationState(NavBarItem.currentRide, 1));
        break;
      case NavBarItem.wallet:
        emit(NavigationState(NavBarItem.wallet, 2));
        break;
    }
  }
}
