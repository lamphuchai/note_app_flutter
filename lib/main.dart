import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';
import 'package:note_app_flutter/logic/debug/bloc_observer.dart';
import 'package:note_app_flutter/views/app.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  return HydratedBlocOverrides.runZoned(
      () => runApp(App(
            authenticationRepository: AuthenticationRepository(),
            noteRepository: NoteRepository(),
          )),
      storage: storage,
      blocObserver: AppBlocObserver());
}
