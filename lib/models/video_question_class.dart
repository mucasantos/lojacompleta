import 'package:cloud_firestore/cloud_firestore.dart';

class VideoQuestion {
  List<Questions> questions;
  String ruleName;
  String ruleId;
  String videoId;

  VideoQuestion({this.questions, this.ruleName, this.ruleId, this.videoId});

  VideoQuestion.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
    ruleName = json['ruleName'];
    ruleId = json['ruleId'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toMapList() {
    List<Map<String, dynamic>> data = [];
    questions.map((element) {
      data.add({
        'parts': element.parts.map((e) => e.toJson()).toList(),
        'text': element.text,
        'time': element.time
      });
    }).toList();
    return {
      ruleId: {
        'questions': data,
        'ruleId': ruleId,
        'ruleName': ruleName,
        'videoId': videoId,
      }
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    data['ruleName'] = this.ruleName;
    data['ruleId'] = this.ruleId;
    return data;
  }

  VideoQuestion.fromDocument(DocumentSnapshot document, dynamic ruleID) {
    print(ruleID);

    ruleName = document[ruleID]['ruleName'] as dynamic;
    videoId = document[ruleID]['videoId'] as String;
    ruleId = ruleID;
    print('@@@@@@@');
    print(ruleID);
    print('@@@@@@@');
    if (document.data[ruleID] != null) {
      questions = new List<Questions>();
      document.data[ruleID]['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }
}

class Questions {
  List<Parts> parts;
  String text;
  int time;

  Questions({this.parts, this.text, this.time});

  Questions.fromJson(Map<String, dynamic> json) {
    if (json['parts'] != null) {
      parts = new List<Parts>();
      json['parts'].forEach((v) {
        parts.add(new Parts.fromJson(v));
      });
    }
    text = json['text'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parts != null) {
      data['parts'] = this.parts.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['time'] = this.time;
    return data;
  }
}

class Parts {
  bool gap;
  String part;

  Parts({this.gap, this.part});

  Parts.fromJson(Map<String, dynamic> json) {
    gap = json['gap'];
    part = json['part'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gap'] = this.gap;
    data['part'] = this.part;
    return data;
  }
}
