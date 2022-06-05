import 'dart:convert';

import 'package:flutter_newsapp/domain/models/news_source_entity.dart';

NewsSourceResponse newsSourceModelFromJson(String str) =>
    NewsSourceResponse.fromJson(json.decode(str));

String newsSourceModelToJson(NewsSourceResponse data) =>
    json.encode(data.toJson());

class NewsSourceResponse {
  NewsSourceResponse({
    this.status,
    this.sources,
  });

  String status;
  List<NewsSource> sources;

  factory NewsSourceResponse.fromJson(Map<String, dynamic> json) =>
      NewsSourceResponse(
        status: json["status"],
        sources: List<NewsSource>.from(
            json["sources"].map((x) => NewsSource.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
      };
}

class NewsSource {
  NewsSource({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  factory NewsSource.fromJson(Map<String, dynamic> json) => NewsSource(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: json["category"],
        language: json["language"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": category,
        "language": language,
        "country": country,
      };

  NewsSourceEntity toEntity() =>
      NewsSourceEntity(
          id: id,
          name: name,
          description: description,
          url: url,
          category: category,
          language: language,
          country: country);
}
