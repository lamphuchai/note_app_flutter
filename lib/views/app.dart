import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/app/router/app_router.dart';
import 'package:note_app_flutter/app/types/app_enum.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';
import 'package:note_app_flutter/logic/blocs/authentication/authentication_bloc.dart';
import 'package:note_app_flutter/views/home/home.dart';
import 'package:note_app_flutter/views/sign_in/sign_in.dart';

class App extends StatelessWidget {
  const App(
      {Key? key,
      required this.authenticationRepository,
      required this.noteRepository})
      : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final NoteRepository noteRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: noteRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(authenRepository: authenticationRepository),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          bottomSheetTheme: const BottomSheetThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10)))),
          useMaterial3: true),
      initialRoute: "/",
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              final id =
                  context.read<AuthenticationRepository>().currentUser().id;
              context.read<NoteRepository>().initial(id);
              break;
            case AuthenticationStatus.unauthenticated:
              break;
            default:
              break;
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              return const HomeView();
            case AuthenticationStatus.unauthenticated:
              return const SignInView();
            default:
              return Scaffold(
                  body: Container(
                color: Colors.red,
              ));
          }
        },
      ),
    );
  }
}
