// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qaydlar_uz/components/my_drawer.dart';
import 'package:qaydlar_uz/database/notes_database.dart';
import 'package:qaydlar_uz/models/notes_model.dart';
import 'package:qaydlar_uz/pages/openData/open_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    Provider.of<NotesDatabase>(context, listen: false).readNote();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final noteDatabase = context.watch<NotesDatabase>();
    List<NotesModel> currentNotes = noteDatabase.allNotes;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Qaydlar.uz",
          style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 23,
              fontWeight: FontWeight.w600),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                FontAwesomeIcons.barsStaggered,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            );
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewNote(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: currentNotes.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: OpenNotePage(currentNote: note),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    overlayColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.tertiary),
                    child: ListTile(
                      tileColor: Theme.of(context).colorScheme.tertiary,
                      title: Text(
                        note.title,
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void createNewNote() {
    titleController.clear();
    descriptionController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Yangi qayd",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Qayd nomi",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  border: const OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                controller: titleController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Qayd tanasi",
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                maxLines: 11,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500),
                ],
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                controller: descriptionController,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Bekor qilish",
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                NotesModel newModel = NotesModel(
                    title: titleController.text,
                    description: descriptionController.text);
                context.read<NotesDatabase>().createNote(newModel);
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              }
            },
            child: Text(
              "Yaratish",
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
