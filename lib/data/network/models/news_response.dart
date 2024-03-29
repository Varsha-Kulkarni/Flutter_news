import 'dart:convert';

import 'package:flutter_newsapp/domain/models/article_entity.dart';

NewsResponse newsModelFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String newsModelToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  NewsResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() =>
      {
        "source": source.toJson(),
        "author": author == null ? null : author,
        "title": title,
        "description": description == null ? null : description,
        "url": url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt,
        "content": content == null ? null : content,
      };

  ArticleEntity toEntity() =>
      ArticleEntity(
          source: source.name,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
          isBookmarked: 0);
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ? null : id,
        "name": name,
      };

// SourceEntity toEntity() => SourceEntity(id: id, name: name);
}
