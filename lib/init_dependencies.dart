import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
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
import 'features/blog/data/repositories/blog_repository_impl.dart';
import 'features/blog/domain/repositories/blog_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: Api.baseUrl,
    anonKey: Api.apiKey,
  );

  sl.registerLazySingleton(() => supabase.client);
  sl.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  //Datasources
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    //Repositories
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()))
    //Usecases
    ..registerFactory(() => UserSignUp(sl()))
    ..registerFactory(() => UserLogin(sl()))
    ..registerFactory(() => CurrenUser(sl()))
    //Blocs
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: sl(),
        userLogin: sl(),
        currentUser: sl(),
        appUserCubit: sl(),
      ),
    );
}

void _initBlog() {
  sl
    //Datasources
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(sl()),
    )
    //Repositories
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(sl()))
    //Usecases
    ..registerFactory(() => UploadBlog(sl()))
    //Blocs
    ..registerLazySingleton(() => BlogBloc(sl()));
}
