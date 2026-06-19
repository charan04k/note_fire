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
import 'features/notes/data/datasource/notes_remote_datasource.dart';
import 'features/notes/data/repository/notes_repository_impl.dart';
import 'features/notes/domain/repository/notes_repository.dart';
import 'features/notes/domain/usecases/add_note_usecase.dart';
import 'features/notes/domain/usecases/delete_note_usecase.dart';
import 'features/notes/domain/usecases/get_notes_usecase.dart';
import 'features/notes/domain/usecases/update_note_usecase.dart';
import 'features/notes/presentation/bloc/notes_bloc.dart';

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


  sl.registerLazySingleton(
        () => NotesRemoteDatasource(
      firestore: sl(),
      auth: sl(),
    ),
  );

  sl.registerLazySingleton<NotesRepository>(
        () => NotesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => AddNoteUsecase(sl()));
  sl.registerLazySingleton(() => GetNotesUsecase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUsecase(sl()));

  sl.registerFactory(
        () => NotesBloc(
      addNoteUsecase: sl(),
      getNotesUsecase: sl(),
      updateNoteUsecase: sl(),
      deleteNoteUsecase: sl(),
    ),
  );
}