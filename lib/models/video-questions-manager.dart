import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/video_question_class.dart';

class VideoQuestionsManager extends ChangeNotifier {
  VideoQuestionsManager() {
    _loadAllQuestions();
  }

  final Firestore firestore = Firestore.instance;
  List<VideoQuestion> allQuestions = [];

  String _search = '';
  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      // filteredProducts.addAll(allProducts);
    } else {
      //  filteredProducts.addAll(allProducts.where((element) =>
      //      element.name.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredProducts;
  }

  Future<void> _loadAllQuestions() async {
    final QuerySnapshot snapQuestions =
        await firestore.collection('videoQuestions').getDocuments();
    List<String> allruleID = [];

    snapQuestions.documents.forEach((e) => e.data.keys.forEach((element) {
          allruleID.add(element);
        }));

    // var videoId = snapQuestions.documents.map((e) => e.data['videoId']);

    //print(videoId);

    for (int index = 0; index < allruleID.length; index++) {
      print(allruleID[index]);

      snapQuestions.documents
          .map((d) =>
              allQuestions.add(VideoQuestion.fromDocument(d, allruleID[index])))
          .toList();
    }

    allQuestions.forEach((element) {
      print(element.ruleId);
      print(element.ruleName);
      print(element.ruleId);
      //  print(element.questions.first.text);
    });

    addToFirebase(
      allQuestions,
    );
    notifyListeners();
  }

  void addToFirebase(
    List<VideoQuestion> questions,
  ) {
    var all = questions.map((e) => e.toMapList()).toList();
    // Map<String, dynamic> forFire = {'videoId': videoId};
    Map<String, dynamic> forFire = {};
    //print(videoId);

//Pega a lista de questões e adiciona ao Map, e assim grava no firebase em um único documento!

    all.forEach((element) {
      forFire.addAll(element);
    });
    firestore.collection('videoQuestions').document("videoId").setData(forFire);
  }

  Product findProductById(String id) {
    print(id);
    try {
      //    return allProducts.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }
}
