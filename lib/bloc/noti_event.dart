part of 'noti_bloc.dart';

@immutable
abstract class NotiEvent {}

class SendNoti extends NotiEvent {
  final String title, body;

  SendNoti(this.title, this.body);
}
