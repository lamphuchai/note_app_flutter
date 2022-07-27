import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/models/email.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/views/components/components.dart';

class ChangeEmailUserModal extends StatelessWidget {
  const ChangeEmailUserModal({Key? key, required this.valueNotifier})
      : super(key: key);

  final ValueNotifier<Email> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Thay đổi email"),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        if (valueNotifier.value.errorText != null) {
          valueNotifier.value = Email.empty;
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
                            "Thay đổi email mới",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                          const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                          ValueListenableBuilder(
                            valueListenable: valueNotifier,
                            builder: (context, value, child) {
                              return CustomTextField(
                                hintText: "Nhập tên email mới",
                                errorText: valueNotifier.value.errorText,
                                onChanged: (text) =>
                                    valueNotifier.value = Email.validator(text),
                              );
                            },
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
                                    .changeEmail(valueNotifier.value.value);
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
