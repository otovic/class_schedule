import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import './DataModel.dart';

part 'DataState.dart';
part 'DataEvents.dart';

class DataBloc extends Bloc<SubjectEvents, DataState> {
  DataBloc() : super(DataState.empty()) {
    on<StatusChangedd>((event, emit) => statusChanged(event, emit));
  }

  Future<void> statusChanged(StatusChangedd event, Emitter<DataState> emit) async {
    switch(event.status) {
      case ReadStatus.notstarted:
        return emit(DataState.empty());
      case ReadStatus.success:
        return emit(DataState.dataread(Subject('Petar', "otovic")));
    }
  }
}