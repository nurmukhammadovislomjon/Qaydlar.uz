import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoAppPage extends StatefulWidget {
  const InfoAppPage({super.key});

  @override
  State<InfoAppPage> createState() => _InfoAppPageState();
}

class _InfoAppPageState extends State<InfoAppPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "texnologiya",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    "Flutter",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "ma'lumot saqlash",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    "Isar database",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "dasturchi",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    "Islomjon Nurmuhammadov",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.25,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      final youtubeUrl =
                          Uri.parse("https://www.youtube.com/@withislomjon");
                      launchUrl(
                        youtubeUrl,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      final telegram = Uri.parse("https://t.me/with_islomjon");
                      launchUrl(
                        telegram,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.telegram,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      final instagramUrl = Uri.parse(
                          "https://www.instagram.com/islomjon_official__");
                      launchUrl(instagramUrl,
                          mode: LaunchMode.externalApplication);
                    },
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
