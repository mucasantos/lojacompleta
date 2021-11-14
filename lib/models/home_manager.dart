import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  List<Section> _sections = [];

  List<Section> _editingSections = [];

  bool editing = false;
  bool loading = false;
  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').orderBy('pos').snapshots().listen((snapshot) {
      _sections.clear(); // Apaga as sessões antes, para não duplicar
      for (final DocumentSnapshot document in snapshot.documents) {
        _sections.add(Section.fromDocument(document));
      }

      print(_sections[0]);
      notifyListeners();
    });
  }

  List<Section> get sections {
    if (editing) {
      return _editingSections;
    } else {
      return _sections;
    }
  }

  void enterEditing() {
    editing = true;

    _editingSections = _sections.map((sections) => sections.clone()).toList();
    notifyListeners();
  }

  void saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }
    if (!valid) return;

    loading = true;
    notifyListeners();
    int pos = 0;
    for (final section in _editingSections) {
      await section.save(pos);
      pos++;
    }
    for (final section in List.from(_sections)) {
      if (!_editingSections.any((element) => element.id == section.id)) {
        await section.delete();
      }
    }
    editing = false;
    loading = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }
}
