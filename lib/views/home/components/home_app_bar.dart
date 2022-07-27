import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/app/config/config.dart';
import 'package:note_app_flutter/app/router/route_name.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';
import 'package:note_app_flutter/logic/blocs/notes/notes_bloc.dart';
import 'package:note_app_flutter/views/components/components.dart';
import 'package:note_app_flutter/views/home/home.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.preferredSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isDeleteItems) {
          return AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.read<HomeCubit>().closeDeleteNotes(),
            ),
            centerTitle: true,
            title: state.listIdNotes.isEmpty
                ? const Text("Chọn mục")
                : Text('Đã chọn ${state.listIdNotes.length} mục'),
            actions: [
              if (state.selectAllNote) ...[
                IconButton(
                    onPressed: () {
                      final notes = (context.read<NotesBloc>().state as NotesLoaded).notes;
                      final listId = notes.map((note) => note.id).toList();
                      context
                          .read<HomeCubit>()
                          .actionType("select-all", listId: listId);
                    },
                    icon: const Icon(Icons.playlist_add_check))
              ] else ...[
                IconButton(
                    onPressed: () => context.read<HomeCubit>().actionType(
                          "unselect-all",
                        ),
                    icon: const Icon(
                      Icons.playlist_remove,
                      color: Colors.green,
                    ))
              ]
            ],
          );
        }
        return AppBar(
          centerTitle: true,
          title: const Text("Ghi chú"),
          actions: [
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, RouteName.user),
                child: Container(
                  padding: EdgeInsets.only(right: AppConfig().appPadding - 6),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Builder(builder: (context) {
                      final photoUrl = context
                          .read<AuthenticationRepository>()
                          .currentUser()
                          .photoUrl;
                      if (photoUrl == null) {
                        return CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(AppAssets.avatarImage));
                      }
                      return CustomCachedNetworkImage(
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          imageUrl: photoUrl);
                    }),
                  ),
                ))
          ],
        );
      },
    );
  }

  @override
  final Size preferredSize;
}
