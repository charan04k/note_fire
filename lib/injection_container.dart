import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/datasource/auth_remote_datasource.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';

import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // DataSource
  sl.registerLazySingleton(
        () => AuthRemoteDataSource(
      auth: sl(),
      firestore: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(
        () => RegisterUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => LoginUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => LogoutUseCase(sl()),
  );

  // Bloc
  sl.registerFactory(
        () => AuthBloc(
      registerUseCase: sl(),
      loginUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}