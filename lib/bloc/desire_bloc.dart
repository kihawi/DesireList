import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/models/desire.dart';
import 'package:flutter_projects/services/desire_repository.dart';

part 'desire_event.dart';
part 'desire_state.dart';

class DesireBloc extends Bloc<DesireEvent, DesireState> {
  DesireBloc() : super(DesireInitial()) {
    on<LoadDesireListEvent>((event, emit) async {
      emit(DesireListLoadingState());
      final desireList = await DesireRepository().getAllDesires();
      emit(DesireListLoadedState(desireList: desireList));
    });
  }
}
