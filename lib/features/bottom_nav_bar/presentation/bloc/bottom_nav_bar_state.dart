part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState extends Equatable {
  final int currentIndex;

  const BottomNavBarState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class BottomNavBarInitial extends BottomNavBarState {
  const BottomNavBarInitial() : super(currentIndex: 0);
}
