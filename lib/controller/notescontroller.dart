import 'package:hive/hive.dart';
import 'package:notes_app/model/models.dart';
import 'package:notes_app/utils/databases/database.dart';

class NotesController {
  final Box<NoteModel> _myBox = Hive.box<NoteModel>('noteBox');

// load data
  Future<List<NoteModel>> loadData() async {
    return _myBox.values.toList();
  }

// add data
  Future<void> addNote(NoteModel note) async {
    notes.add(note);
    await _myBox.add(note);
  }

  Future<void> deleteNote(int index) async {
    notes.removeAt(index);
    await _myBox.deleteAt(index);
  }
}
