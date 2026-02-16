import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/api/api.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/curren_user.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: Api.baseUrl,
    anonKey: Api.apiKey,
  );

  sl.registerLazySingleton(() => supabase.client);
  sl.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerFactory(() => UserSignUp(sl()))
    ..registerFactory(() => UserLogin(sl()))
    ..registerFactory(() => CurrenUser(sl()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: sl(),
        userLogin: sl(),
        currentUser: sl(),
        appUserCubit: sl(),
      ),
    );
}
