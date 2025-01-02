import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [
  new CardModel("Cardiologist", 0xFFec407a, Icons.favorite), // Heart icon
  new CardModel("Dentist", 0xFF5c6bc0, Icons.medical_services), // Tooth icon alternative
  new CardModel("Eye Special", 0xFFfbc02d, Icons.visibility), // Eye icon
  new CardModel("Orthopaedic", 0xFF1565C0, Icons.accessible), // Wheelchair icon
  new CardModel("Paediatrician", 0xFF2E7D32, Icons.child_care), // Baby icon
];
