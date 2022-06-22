import 'package:chat_app/core/usecases/use_case_stream.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';

class GetAllUsersUseCase
    implements UseCaseStream<List<UserEntity>, NoParamsStream> {
  final FirebaseRepository firebaseRepository;

  GetAllUsersUseCase(this.firebaseRepository);

  @override
  Stream<List<UserEntity>> call(NoParamsStream params) =>
      firebaseRepository.getAllUsers();
}
