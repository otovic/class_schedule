import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_events.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(ScheduleState.changeDate(currentDate: DateTime.now())) {
    on<ChangeDate>((event, emit) => _setNewDate(event, emit));
  }

  Future<void> _setNewDate(
      ChangeDate event, Emitter<ScheduleState> state) async {
    print(event.newDate);
    emit(ScheduleState.changeDate(currentDate: event.newDate));
  }
}
