import 'package:chat_app/core/usecases/use_case.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetCurrentUserInfoUseCase implements UseCase<UserEntity, NoParams> {
  final FirebaseRepository firebaseRepository;

  GetCurrentUserInfoUseCase(this.firebaseRepository);
  @override
  Future<UserEntity> call(NoParams params) async {
    return firebaseRepository.getCurrentUserInfo();
  }
}
