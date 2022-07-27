import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_app_flutter/app/config/config.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';
import 'package:note_app_flutter/app/router/route_name.dart';
import 'package:note_app_flutter/views/components/components.dart';
import 'package:note_app_flutter/views/sign_in/sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Đăng nhập"),
      ),
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state.status == SignInStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Có lỗi thử lại sau")));
          }
          if (state.message != "") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppConfig().appPadding),
          child: Column(
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
              BlocBuilder<SignInCubit, SignInState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return CustomTextField(
                    hintText: "Email",
                    textInputAction: TextInputAction.next,
                    errorText: state.email.errorText,
                    textInputType: TextInputType.emailAddress,
                    onChanged: (email) =>
                        context.read<SignInCubit>().onChangeEmail(email),
                  );
                },
              ),
              SizedBox(
                height: context.screenSize.height * 0.02,
              ),
              BlocBuilder<SignInCubit, SignInState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return CustomTextFieldPassword(
                    hintText: "Password",
                    errorText: state.password.errorText,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    onChanged: (password) =>
                        context.read<SignInCubit>().onChangePassword(password),
                  );
                },
              ),
              SizedBox(
                height: context.screenSize.height * 0.05,
              ),
              AppButtonLong(
                  onPressed: () async {
                    context.read<SignInCubit>().signInWithEmail();
                  },
                  child: BlocSelector<SignInCubit, SignInState, bool>(
                    selector: (state) {
                      return state.status == SignInStatus.loading;
                    },
                    builder: (context, status) => status
                        ? const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Đăng nhập",
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
                children: const [
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Hoặc"),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  )),
                ],
              ),
              SizedBox(
                height: context.screenSize.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.read<SignInCubit>().signInWithGoogle(),
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: SvgPicture.asset(AppAssets.googleIcon),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: SvgPicture.asset(AppAssets.facebookIcon),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: context.screenSize.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bạn chưa có tài khoản?"),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, RouteName.signUp),
                      child: const Text("Đăng ký"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
