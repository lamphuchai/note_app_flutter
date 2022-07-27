import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/app/config/config.dart';
import 'package:note_app_flutter/data/models/models.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/views/components/components.dart';
import 'package:note_app_flutter/views/user/user.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Cá nhân"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                final user = state.user;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      minRadius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: user.photoUrl == null
                          ? Image.asset(AppAssets.avatarImage).image
                          : CachedNetworkImageProvider(user.photoUrl!),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user.displayName != null) ...[
                            Text(
                              user.displayName!,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                          Text(
                            user.email,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ))
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          UpdateNameUserModal(
            valueNotifier: ValueNotifier(user.email),
          ),
          BlocSelector<UserBloc, UserState, String>(
            selector: (state) {
              return state.user.email;
            },
            builder: (context, email) {
              return ChangeEmailUserModal(
                valueNotifier: ValueNotifier(Email(value: email)),
              );
            },
          ),
          ChangePasswordUserModal(),
          ListTile(
            title: const Text("Đăng xuất"),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Wrap(
                            children: [
                              const SizedBox(
                                height: 20,
                                width: double.infinity,
                              ),
                              Center(
                                  child: Text(
                                "Đăng xuất ?",
                                style: Theme.of(context).textTheme.titleMedium,
                              )),
                              const SizedBox(
                                height: 30,
                                width: double.infinity,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppButtonShort(
                                      color: Colors.red[400],
                                      child: const Text(
                                        "Đăng xuất",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<AuthenticationRepository>()
                                            .signOut();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, "/", (route) => false);
                                      }),
                                  AppButtonShort(
                                      child: const Text(
                                        "Thoát",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      onPressed: () => Navigator.pop(context)),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ));
            },
          )
        ],
      ),
    );
  }
}
