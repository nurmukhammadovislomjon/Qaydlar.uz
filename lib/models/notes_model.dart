import 'package:isar/isar.dart';

part 'notes_model.g.dart';

@Collection()
class NotesModel {
  Id id = Isar.autoIncrement;
  late String title;
  late String description;

  NotesModel({required this.title, required this.description});
}
