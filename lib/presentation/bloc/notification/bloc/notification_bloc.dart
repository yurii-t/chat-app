import 'package:bloc/bloc.dart';
import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/usecases/get_device_token_usecase.dart';
import 'package:chat_app/domain/usecases/receive_notification_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ReceiveNotificationUseCase receiveNotificationUseCase;
  final GetDeviceTokenUseCase getDeviceTokenUseCase;
  NotificationBloc(this.receiveNotificationUseCase, this.getDeviceTokenUseCase)
      : super(NotificationInitial()) {
    on<NotificationReceive>((event, emit) async {
      await emit.forEach(
        receiveNotificationUseCase.call(NoParams()),
        onData: (notification) =>
            NotificationReceived(notification as RemoteMessage),
      );
    });
    on<NotificationUpdateToken>(
      (event, emit) => getDeviceTokenUseCase.call(NoParams()),
    );
  }
}
