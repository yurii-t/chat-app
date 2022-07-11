// ignore_for_file: avoid-unused-parameters
import 'package:bloc/bloc.dart';
import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/usecases/get_current_user_uid_usecase.dart';
import 'package:chat_app/domain/usecases/is_signin_usecase.dart';
import 'package:chat_app/domain/usecases/signout_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final GetCurrentUserUidUseCase getCurrentUserUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  AuthStatusBloc({
    required this.getCurrentUserUidUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase,
  }) : super(AuthStatusInitial()) {
    on<AuthStatusStarted>(onAuthStatusStarted);
    on<AuthStatusLogedIn>(onAuthStatusLogedIn);
    on<AuthStatusLogedOut>(onAuthStatusLogedOut);
  }

  Future<void> onAuthStatusStarted(
    AuthStatusStarted event,
    Emitter<AuthStatusState> emit,
  ) async {
    try {
      final bool isSignIn = await isSignInUseCase.call(NoParams());
      if (isSignIn) {
        final String uid = await getCurrentUserUidUseCase.call(NoParams());
        emit(Authenticated(uid: uid));
      } else
        emit(UnAuthenticated());
    } on Exception catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> onAuthStatusLogedIn(
    AuthStatusLogedIn event,
    Emitter<AuthStatusState> emit,
  ) async {
    try {
      final String uid = await getCurrentUserUidUseCase.call(NoParams());
      emit(Authenticated(uid: uid));
    } on Exception catch (_) {}
  }

  Future<void> onAuthStatusLogedOut(
    AuthStatusLogedOut event,
    Emitter<AuthStatusState> emit,
  ) async {
    try {
      await signOutUseCase.call(NoParams());
      emit(UnAuthenticated());
    } on Exception catch (_) {}
  }
}
