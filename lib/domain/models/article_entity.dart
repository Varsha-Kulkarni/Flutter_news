import 'map_convertible.dart';

class ArticleEntity extends MapConvertible {
  ArticleEntity({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.isBookmarked,
  });

  String source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  int isBookmarked;

  ArticleEntity.map(dynamic obj) {
    this.source = obj['source'];
    this.title = obj['title'];
    this.description = obj['description'];
    this.author = obj['author'];
    this.url = obj['url'];
    this.urlToImage = obj['urlToImage'];
    this.publishedAt = obj['publishedAt'];
    this.content = obj['content'];
    this.isBookmarked = obj['isBookmarked'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
      'author': author,
      'isBookmarked': isBookmarked,
      'publishedAt': publishedAt
    };
  }

  @override
  ArticleEntity fromMap(Map map) {
    return ArticleEntity(
        source: map['source'],
        title: map['title'],
        description: map['description'],
        author: map['author'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'],
        content: map['content'],
        isBookmarked: map['isBookmarked']);
  }
}
