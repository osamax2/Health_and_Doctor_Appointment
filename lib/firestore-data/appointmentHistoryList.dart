import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentHistoryList extends StatefulWidget {
  @override
  _AppointmentHistoryListState createState() => _AppointmentHistoryListState();
}

class _AppointmentHistoryListState extends State<AppointmentHistoryList> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  String _dateFormatter(String _timestamp) {
     DateTime dateTime = DateTime.parse(_timestamp);

  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  return '$day-$month-$year'; // dd-MM-yyyy
  }

  Future<void> deleteAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc(user.email.toString())
        .collection('all')
        .doc(docID)
        .delete();
  }

  // ignore: unused_element
  String _timeFormatter(String _timestamp) {
   DateTime dateTime = DateTime.parse(_timestamp);

  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  return '$hour:$minute'; // kk:mm
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .doc(user.email.toString())
            .collection('all')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data?.size == 0
              ? Text(
                  'History Appears here...',
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document['doctor'],
                                style: GoogleFonts.lato(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _dateFormatter(
                                    document['date'].toDate().toString()),
                                style: GoogleFonts.lato(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
