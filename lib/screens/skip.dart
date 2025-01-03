
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'firebaseAuth.dart';

class Skip extends StatefulWidget {
  @override
  _SkipState createState() => _SkipState();
}

class _SkipState extends State<Skip> {
  List<PageViewModel> getpages() {
    return [
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/berlin-embassy-ar.png',
          //fit: BoxFit.cover,
        ),
        //body: "ابحث عن خدماتنا",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'سجل موعد',
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              'يمكنك الأن إيجاد موعد بأسرع وقت ممكن',
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/active-search-512.png',
          fit: BoxFit.cover,
          width: 300,
        ),
        //body: "Search Doctors",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'البحث في خدماتنا',
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              'ابحث عن معلومات حول جميع خدماتنا',
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getpages(),
        showNextButton: false,
        showSkipButton: true,
        skip: SizedBox(
          width: 80,
          height: 48,
          child: Card(
            child: Center(
              child: Text(
                'تخطي',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Color.fromRGBO(0, 122, 61, 0.4),
            shadowColor: Colors.blueGrey[100],
            elevation: 5,
          ),
        ),
        done: SizedBox(
          height: 48,
          child: Card(
            child: Center(
              child: Text(
                'متابعة',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Color.fromRGBO(0, 122, 61, 0.4),
            shadowColor: Colors.blueGrey[200],
            elevation: 5,
          ),
        ),
        onDone: () => _pushPage(context, FireBaseAuth()),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
