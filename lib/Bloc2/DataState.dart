part of 'DataBloc.dart';

class DataState {
  final Subject data;
  final ReadStatus? status;

  DataState._({ this.data = Subject.empty, this.status = ReadStatus.notstarted });

  DataState.empty() : this._();

  DataState.dataread(Subject subject) : this._(data: subject, status: ReadStatus.success);

  DataState.readfailed() : this._(status: ReadStatus.failed);
}