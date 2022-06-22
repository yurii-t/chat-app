import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class CreateCurrentUserUseCase implements UseCase<void, UserEntity> {
  final FirebaseRepository firebaseRepository;

  CreateCurrentUserUseCase(this.firebaseRepository);
  @override
  Future<void> call(UserEntity user) async {
    await firebaseRepository.createCurrentUser(user);
  }
}
