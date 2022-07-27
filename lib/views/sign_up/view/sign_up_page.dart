import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app_flutter/app/config/config.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';
import 'package:note_app_flutter/app/types/app_enum.dart';
import 'package:note_app_flutter/logic/blocs/blocs.dart';
import 'package:note_app_flutter/views/components/components.dart';
import 'package:note_app_flutter/views/sign_up/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Đăng ký"),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            }
          })),
          BlocListener<SignUpCubit, SignUpState>(listener: ((context, state) {
            if (state.status == SignUpStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Có lỗi thử lại sau")));
            }
          }))
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppConfig().appPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.screenSize.height * 0.02,
              ),
              SizedBox(
                width: context.screenSize.width,
                height: context.screenSize.height * 1 / 6,
                child: Center(child: SvgPicture.asset(AppAssets.noteIcon)),
              ),
              SizedBox(
                height: context.screenSize.height * 0.02,
              ),
              BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return CustomTextField(
                    hintText: "Email",
                    errorText: state.email.errorText,
                    textInputAction: TextInputAction.next,
                    onChanged: (email) =>
                        context.read<SignUpCubit>().onChangeEmail(email),
                  );
                },
              ),
              SizedBox(
                height: context.screenSize.height * 0.02,
              ),
              BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return CustomTextFieldPassword(
                    hintText: "Password",
                    errorText: state.password.errorText,
                    textInputAction: TextInputAction.done,
                    onChanged: (password) =>
                        context.read<SignUpCubit>().onChangePassword(password),
                  );
                },
              ),
              SizedBox(
                height: context.screenSize.height * 0.05,
              ),
              AppButtonLong(
                  onPressed: () async {
                    context.read<SignUpCubit>().signUpWithEmail();
                  },
                  child: BlocSelector<SignUpCubit, SignUpState, bool>(
                    selector: (state) {
                      return state.status == SignUpStatus.loading;
                    },
                    builder: (context, loading) => loading
                        ? const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Đăng ký",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                  )),
              SizedBox(
                height: context.screenSize.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bạn đã có tài khoản?"),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Đăng nhập"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
