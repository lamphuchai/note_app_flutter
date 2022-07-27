import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:note_app_flutter/app/config/app_config.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';
import 'package:note_app_flutter/views/note/note.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NoteCubit, NoteState, int>(
      selector: (state) {
        return state.note.color;
      },
      builder: (context, color) {
        return WillPopScope(
          onWillPop: () async {
            context.read<NoteCubit>().saveNote();
            return true;
          },
          child: Scaffold(
            backgroundColor: Color(color),
            appBar: AppBar(
              backgroundColor: Color(color),
              actions: [
                KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                    if (isKeyboardVisible) {
                      return IconButton(
                        splashRadius: 24,
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          context.read<NoteCubit>().saveNote();
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConfig().appPadding),
                    child: Column(
                      children: const [
                        TitleNoteTextField(),
                        ContentNoteTextField()
                      ],
                    ),
                  )),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectColorModal(
                              color: ValueNotifier(color),
                              changeColor: (color) => context
                                  .read<NoteCubit>()
                                  .onChangeColor(color)),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: BlocBuilder<NoteCubit, NoteState>(
                            buildWhen: (previous, current) =>
                                previous.note.updateAt != current.note.updateAt,
                            builder: (context, state) {
                              return Text(
                                state.note.updateAt.timeText,
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            },
                          ),
                        )),
                        const Expanded(child: MenuModalNote()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
