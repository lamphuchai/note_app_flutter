import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/models/password.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/views/components/components.dart';

class ChangePasswordUserModal extends StatelessWidget {
  ChangePasswordUserModal({
    Key? key,
  }) : super(key: key);

  final ValueNotifier<Password> valueNotifier = ValueNotifier(Password.empty);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Thay đổi mật khẩu"),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        if (valueNotifier.value.errorText != null) {
          valueNotifier.value = Password.empty;
        }
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SafeArea(
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        children: [
                          const SizedBox(
                            height: 30,
                            width: double.infinity,
                          ),
                          Center(
                              child: Text(
                            "Thay đổi mật khẩu mới",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                          const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                          ValueListenableBuilder(
                            valueListenable: valueNotifier,
                            builder: (context, value, child) => CustomTextField(
                              hintText: "Nhập mật khẩu mới ",
                              errorText: valueNotifier.value.errorText,
                              onChanged: (text) => valueNotifier.value =
                                  Password.validator(text),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                          AppButtonLong(
                            onPressed: () {
                              if (valueNotifier.value.errorText == null) {
                                context
                                    .read<AuthenticationRepository>()
                                    .changePassword(valueNotifier.value.value);
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Lưu lại",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
      },
    );
  }
}
