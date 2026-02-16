import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/entities/user.dart';
import '../repositories/auth_repository.dart';

class CurrenUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrenUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
