import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/views/home/home.dart';
import 'package:note_app_flutter/views/note/view/view.dart';

class CustomFloatingButtonAction extends StatelessWidget {
  const CustomFloatingButtonAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.isDeleteItems != current.isDeleteItems,
      builder: (context, state) {
        if (state.isDeleteItems) {
          return Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red,
            ),
            child: IconButton(
                onPressed: () => context.read<HomeCubit>().deleteManyNote(),
                icon: const Icon(Icons.delete)),
          );
        }
        return OpenContainer(
            transitionDuration: const Duration(milliseconds: 400),
            openColor: Colors.white,
            closedColor: Colors.blue,
            openShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            openBuilder: ((context, action) {
              return const NoteView();
            }),
            closedBuilder: (context, action) =>
                const SizedBox(height: 60, width: 60, child: Icon(Icons.add)));
      },
    );
  }
}
