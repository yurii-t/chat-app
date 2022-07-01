import 'package:equatable/equatable.dart';

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParamsStream extends Equatable {
  @override
  List<Object> get props => [];
}
