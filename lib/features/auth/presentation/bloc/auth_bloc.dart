import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/curren_user.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrenUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrenUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _currentUser = currentUser,
       _userLogin = userLogin,
       _userSignUp = userSignUp,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(NoParams());

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
