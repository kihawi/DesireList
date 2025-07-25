part of 'desire_bloc.dart';

class DesireState {}

class DesireInitial extends DesireState {}

class DesireListinitial extends DesireState {}

class DesireListLoading extends DesireState {}

class DesireListLoaded extends DesireState {
  DesireListLoaded({required this.desireList});
  final List<Desire> desireList;
}
