import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/views/components/components.dart';

class UpdateNameUserModal extends StatelessWidget {
  const UpdateNameUserModal({Key? key, required this.valueNotifier})
      : super(key: key);

  final ValueNotifier<String> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Tên hiển thị"),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
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
                            "Thay đổi tên hiển thị",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                          const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                          CustomTextField(
                            hintText: "Nhập tên mới",
                            onChanged: (text) => valueNotifier.value = text,
                          ),
                          const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                          AppButtonLong(
                            onPressed: () {
                              context
                                  .read<AuthenticationRepository>()
                                  .updateName(valueNotifier.value);
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
