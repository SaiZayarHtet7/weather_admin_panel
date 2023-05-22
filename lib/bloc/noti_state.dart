part of 'noti_bloc.dart';

@immutable
abstract class NotiState {}

class NotiInitial extends NotiState {}

class NotiSendSuccess extends NotiState {}

class NotiSendLoading extends NotiState {}

class NotiSendError extends NotiState {
  final String error;

  NotiSendError(this.error);
}
