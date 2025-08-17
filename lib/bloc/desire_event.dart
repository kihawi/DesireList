part of 'desire_bloc.dart';

class DesireEvent {}

class LoadDesireListEvent extends DesireEvent {}

class AddDesireEvent extends DesireEvent {
  final Desire desire;
  AddDesireEvent(this.desire);
}
