import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app_flutter/app/config/config.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';
import 'package:note_app_flutter/logic/blocs/blocs.dart';
import 'package:note_app_flutter/views/home/home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_flutter/views/note/view/view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
          preferredSize:
              Size((MediaQuery.of(context).size.width), kToolbarHeight)),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesLoaded) {
              if (state.notes.isEmpty) {
                return SizedBox(
                  height: context.screenSize.height,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.noteIcon,
                            height: 150,
                          ),
                          Text(
                            "Ghi chú trống",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, homeState) {
                return MasonryGridView.count(
                    padding: const EdgeInsets.only(left: 7, right: 7, top: 10),
                    itemCount: state.notes.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      final isNoteBorder =
                          homeState.listIdNotes.contains(note.id);
                      return OpenContainer(
                        key: ValueKey(note.id),
                        transitionDuration: const Duration(milliseconds: 400),
                        openColor: Color(note.color),
                        closedColor: Color(note.color),
                        openShape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        closedShape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.5,
                                color: isNoteBorder
                                    ? Colors.green
                                    : (note.color == context.defaultColorValue
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.transparent)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        openBuilder: ((context, action) => NoteView(
                              note: note,
                            )),
                        closedBuilder: (context, child) => GestureDetector(
                          onLongPress: () =>
                              context.read<HomeCubit>().onLongPress(note.id),
                          onTap: homeState.isDeleteItems
                              ? () => context
                                  .read<HomeCubit>()
                                  .selectNoteId(note.id)
                              : null,
                          child: NoteItem(
                            note: note,
                          ),
                        ),
                      );
                    });
              });
            }
            return Container();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const CustomFloatingButtonAction(),
    );
  }
}
