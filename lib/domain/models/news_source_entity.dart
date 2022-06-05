import 'package:flutter_newsapp/domain/models/map_convertible.dart';

class NewsSourceEntity extends MapConvertible {
  NewsSourceEntity({
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

  NewsSourceEntity.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.description = obj['description'];
    this.url = obj['url'];
    this.category = obj['category'];
    this.language = obj['language'];
    this.country = obj['country'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'category': category,
      'language': language,
      'country': country,
    };
  }

  @override
  NewsSourceEntity fromMap(Map map) {
    return NewsSourceEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      url: map['url'],
      category: map['category'],
      language: map['language'],
      country: map['country'],
    );
  }
}
