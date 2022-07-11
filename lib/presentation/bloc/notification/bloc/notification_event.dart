part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationReceive extends NotificationEvent {}

class NotificationUpdateToken extends NotificationEvent {}
