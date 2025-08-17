part of 'desire_bloc.dart';

class DesireState {}

class DesireInitial extends DesireState {}

class DesireListinitial extends DesireState {}

class DesireListLoadingState extends DesireState {}

class DesireListLoadedState extends DesireState {
  DesireListLoadedState({required this.desireList});
  final List<Desire> desireList;
}
