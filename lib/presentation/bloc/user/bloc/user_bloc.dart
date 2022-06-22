import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

import 'package:chat_app/domain/usecases/get_all_users_usecase.dart';

import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;

  StreamSubscription? usersSubscription;
  UserBloc({
    required this.getAllUsersUseCase,
  }) : super(UserInitial()) {
    on<LoadAllUsers>(onLoadAllUsers);
  }
  @override
  Future<void> close() {
    usersSubscription?.cancel();

    return super.close();
  }

  void onLoadAllUsers(LoadAllUsers event, Emitter<UserState> emit) async {
    await emit.forEach(
      getAllUsersUseCase.call(NoParamsStream()),
      onData: (List<UserEntity> users) {
        return UserLoaded(allUsers: users);
      },
    );
  }
}
