import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  List<Section> sections = [];
  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear(); // Apaga as sessões antes, para não duplicar
      for (final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocument(document));
      }

      print(sections[0]);
      notifyListeners();
    });
  }
}
