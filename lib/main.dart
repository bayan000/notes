
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Controller/note_controller.dart';
import 'package:untitled/Views/note_list.dart';
import 'package:get_storage/get_storage.dart';

import 'Model/notes_model.dart';


void main() async{

  await GetStorage.init();
  final notesController = Get.put(NotesController());
  notesController.loadNotes();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Notes',
      routes: {
        '/edit-note': (context) => NotesList(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: NotesList(),
    );
  }
}