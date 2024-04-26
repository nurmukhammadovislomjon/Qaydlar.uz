// ignore_for_file: unused_local_variable, prefer_final_fields, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qaydlar_uz/models/notes_model.dart';

class NotesDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<NotesModel> allNotes = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([NotesModelSchema], directory: dir.path);
  }

  Future<void> createNote(NotesModel newModel) async {
    await isar.writeTxn(() => isar.notesModels.put(newModel));
    await readNote();
  }

  Future<void> readNote() async {
    List<NotesModel> fetchedNotes = await isar.notesModels.where().findAll();
    allNotes.clear();
    allNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> updateNote(
      {required int id,
      required String newTitle,
      required String newDescription}) async {
    final existingNote = await isar.notesModels.get(id);
    if (existingNote != null) {
      existingNote.title = newTitle;
      existingNote.description = newDescription;
      print(existingNote.title);
      await isar.writeTxn(() => isar.notesModels.put(existingNote));
      await readNote();
    }
  }

  Future<void> reLoadNote() async {
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(
      () => isar.notesModels.delete(id),
    );
    await readNote();
  }
}
