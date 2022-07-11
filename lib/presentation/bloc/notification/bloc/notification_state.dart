part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationReceived extends NotificationState {
  final RemoteMessage notification;

  const NotificationReceived(this.notification);

  @override
  List<Object> get props => [notification];
}
