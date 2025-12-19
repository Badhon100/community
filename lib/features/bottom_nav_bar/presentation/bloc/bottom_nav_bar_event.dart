part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();

  @override
  List<Object> get props => [];
}

class BottomNavIndexChanged extends BottomNavBarEvent {
  final int index;

  const BottomNavIndexChanged(this.index);

  @override
  List<Object> get props => [index];
}
