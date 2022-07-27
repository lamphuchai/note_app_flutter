import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/views/sign_in/sign_in.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: const SignInPage(),
    );
  }
}
