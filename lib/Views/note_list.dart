import 'package:flutter/material.dart';
import 'package:untitled/bindings/components_for_notes.dart';
import 'package:untitled/Controller/note_controller.dart';
import 'package:get/get.dart';
import 'package:untitled/Model/notes_model.dart';
import 'package:get_storage/get_storage.dart';

class NotesList extends StatelessWidget {

  final NotesController noteController = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.edit, color: Colors.orange),
        title: const Text('Notes', style: TextStyle(color: Colors.orange)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.brightness_2,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.orange
                  : Colors.white,
            ),
            onPressed: () {
              Get.changeTheme(ThemeData(
                brightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
              ));
            },
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [Expanded(
                child: Obx(() => ListView.builder(
                  itemCount:noteController.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteController.notes[index];

                    return ListTile(
                        key: ValueKey(note.id),
                        title: Text(
                        note.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.grey),
                            onPressed: () => noteController.deleteNote(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () => {

                              Get.dialog(EditNoteDialog(id:noteController.notes[index].id)),



                            }, // Pass the note to update
                          ),
                        ],
                      )
                    );
                  },
                )),
              ),]
            ),
            FloatingActionButton(
              onPressed: () => Get.dialog(AddNoteDialog()),
              child: const Icon(Icons.add, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}