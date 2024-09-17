import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/Model/notes_model.dart';

class NotesController extends GetxController {
  final RxList<Note> notes = RxList<Note>([]);

  void initializeStorage() async{
    if (await GetStorage().read('notes') == null) {
      await GetStorage().write('notes', [Note(id: "0", description: "write your notes here..")]);
    }
    else{
      print("oh la la la");
    }
  }
  @override
  void onInit() {
    super.onInit();

    initializeStorage();

    loadNotes();
  }

  void loadNotes() async{
    final storedNotes =await GetStorage().read('notes') as List<Note>;
    if (storedNotes != null) {
      notes.value = storedNotes;
    }

  }

  void addNote(String title)  {
    final newNote = Note(
      id: '${DateTime.now().millisecondsSinceEpoch}-${ GetStorage().read('counter')}',
      description: title,
    );
     GetStorage().write('counter', (GetStorage().read('counter') ?? 0) + 1);
    notes.add(newNote);
    notes.refresh(); // This updates the UI
     GetStorage().write('notes', notes);
     update();
  }

  void updateNote(String id, String title) async {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      notes[index].description = title;
    }
    await GetStorage().write('notes', notes);
    update(); // This triggers UI update
  }

  void deleteNote(int index) async{
    notes.removeAt(index);
    await GetStorage().write('notes', notes);
    update();
  }
}