part of 'DataBloc.dart';

abstract class SubjectEvents {
  const SubjectEvents();
}

class StatusChangedd extends SubjectEvents {
  final ReadStatus status;
  const StatusChangedd(this.status);
}