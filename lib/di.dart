import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/secrets/app_secrets.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initSupabase();
  await _initAuth();

  //Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      userSignUp: sl(),
      userLogin: sl(),
      currentUser: sl(),
      appUserCubit: sl(),
    ),
  );
}

//Supabase
Future<void> _initSupabase() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);

  //Core
  sl.registerLazySingleton(() => AppUserCubit());
}

Future<void> _initAuth() async {
  //Datasource
  sl.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );

  //Repository
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  //Usecases
  sl.registerFactory(() => UserSignUp(sl()));
  sl.registerFactory(() => UserLogin(sl()));
}
