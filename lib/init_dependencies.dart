import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/api/api.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: Api.baseUrl,
    anonKey: Api.apiKey,
  );

  sl.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerFactory(() => UserSignUp(sl()));

  sl.registerLazySingleton(() => AuthBloc(userSignUp: sl()));
}
