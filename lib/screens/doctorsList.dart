import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/firestore-data/searchList.dart';

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  TextEditingController _textController = TextEditingController();
  String search = "";
  var _length = 0;

  @override
  void initState() {
    super.initState();
    search = _textController.text;
    _length = search.length;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Find Doctors',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300]!,
                  hintText: 'Search Doctor',
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black26,
                  ),
                  suffixIcon: _textController.text.isNotEmpty
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _textController.clear();
                              _length = 0;
                            });
                          },
                          child: Icon(
                            Icons.close_rounded,
                            size: 20,
                          ),
                        )
                      : SizedBox(),
                ),
                onChanged: (String _searchKey) {
                  setState(() {
                    search = _searchKey;
                    _length = search.length;
                  });
                },
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textInputAction: TextInputAction.search,
                autofocus: false,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _length == 0
            ? Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _length = 1;
                          });
                        },
                        child: Text(
                          'Show All',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image(image: AssetImage('assets/search-bg.png')),
                    ],
                  ),
                ),
              )
            : SearchList(
                searchKey: search,
              ),
      ),
    );
  }
}
