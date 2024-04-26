import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qaydlar_uz/components/my_drawer.dart';
import 'package:qaydlar_uz/database/notes_database.dart';
import 'package:qaydlar_uz/models/notes_model.dart';
import 'package:qaydlar_uz/pages/home_page.dart';

class OpenNotePage extends StatefulWidget {
  const OpenNotePage({super.key, required this.currentNote});
  final NotesModel currentNote;

  @override
  State<OpenNotePage> createState() => _OpenNotePageState();
}

class _OpenNotePageState extends State<OpenNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    // Provider.of<NotesDatabase>(context, listen: false).readNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                widget.currentNote.title,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10.0),
              child: Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                textAlign: TextAlign.start,
                widget.currentNote.description,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          // left: 10,
          // right: 10,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: () => updateIsNote(
                  widget.currentNote.id,
                  widget.currentNote,
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: () {
                  context
                      .read<NotesDatabase>()
                      .deleteNote(widget.currentNote.id);
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateIsNote(int id, NotesModel yourModel) {
    titleController.text = yourModel.title;
    descriptionController.text = yourModel.description;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Qaydni taxrirlash",
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
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
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
                controller: descriptionController,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
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
                context.read<NotesDatabase>().updateNote(
                      id: id,
                      newTitle: titleController.text,
                      newDescription: descriptionController.text,
                    );
                // Provider.of<NotesDatabase>(context, listen: false).readNote();
                // context.read<NotesDatabase>().reLoadNote();
                titleController.clear();
                descriptionController.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              }
            },
            child: Text(
              "Saqlash",
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
