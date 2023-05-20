// To parse this JSON data, do
//
//     final foundModel = foundModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<FoundModel> foundModelFromJson(String str) =>
    List<FoundModel>.from(json.decode(str).map((x) => FoundModel.fromJson(x)));

String foundModelToJson(List<FoundModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoundModel {
  FoundModel({
    required this.word,
    required this.phonetics,
    required this.meanings,
    required this.license,
    required this.sourceUrls,
  });

  final String word;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;
  final License license;
  final List<String> sourceUrls;

  factory FoundModel.fromJson(Map<String, dynamic> json) => FoundModel(
        word: json["word"],
        phonetics: List<Phonetic>.from(
            json["phonetics"].map((x) => Phonetic.fromJson(x))),
        meanings: List<Meaning>.from(
            json["meanings"].map((x) => Meaning.fromJson(x))),
        license: License.fromJson(json["license"]),
        sourceUrls: List<String>.from(json["sourceUrls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "phonetics": List<dynamic>.from(phonetics.map((x) => x.toJson())),
        "meanings": List<dynamic>.from(meanings.map((x) => x.toJson())),
        "license": license.toJson(),
        "sourceUrls": List<dynamic>.from(sourceUrls.map((x) => x)),
      };
}

class License {
  License({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Meaning {
  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  final String partOfSpeech;
  final List<Definition> definitions;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
      };
}

class Definition {
  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    required this.example,
  });

  final String definition;
  final List<dynamic> synonyms;
  final List<dynamic> antonyms;
  final String? example;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: List<dynamic>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
        example: json["example"] == null ? null : json["example"],
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
        "example": example == null ? null : example,
      };
}

class Phonetic {
  Phonetic({
    required this.audio,
    required this.sourceUrl,
    required this.license,
    required this.text,
  });

  final String audio;
  final String? sourceUrl;
  final License? license;
  final String? text;

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        audio: json["audio"],
        sourceUrl: json["sourceUrl"] == null ? null : json["sourceUrl"],
        license:
            json["license"] == null ? null : License.fromJson(json["license"]),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "audio": audio,
        "sourceUrl": sourceUrl == null ? null : sourceUrl,
        "license": license == null ? null : license!.toJson(),
        "text": text == null ? null : text,
      };
}
