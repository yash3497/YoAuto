part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavBarItem navbarItem;
  final int index;

  const NavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
