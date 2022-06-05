import 'package:flutter_newsapp/domain/models/article_entity.dart';
import 'package:flutter_newsapp/domain/models/news_source_entity.dart';
import 'package:flutter_newsapp/utils/secret_loader.dart';
import 'package:get/get.dart';

import 'database/news_database_helper.dart';
import 'network/models/news_response.dart';
import 'network/news_api_provider.dart';

abstract class INewsRepository {
  Future<List<int>> refreshNews();

  Future<List<ArticleEntity>> getNews();

  Future<NewsResponse> getNewsWithSource(String source);

  Future<List<NewsSourceEntity>> getNewsSources();

  void updateBookmark(ArticleEntity articleEntity);

  Future<List<ArticleEntity>> getBookmarks();

  Future<NewsResponse> searchNews(String source);
}

class NewsRepository implements INewsRepository {
  final INewsProvider provider = Get.put(NewsApiProvider());

  var db = new NewsDatabaseHelper();

  @override
  Future<List<ArticleEntity>> getNews() async {
    var result = await db.getAllNewsArticles();
    return result.map((map) => ArticleEntity().fromMap(map)).toList();
  }

  @override
  Future<List<int>> refreshNews() async {
    List<int> fetchedNewsIds = [];

    String apiKey = await SecretLoader.getApiKey();

    final newsModel =
        await provider.getNews("/top-headlines?country=in&apiKey=$apiKey");

    if (!newsModel.status.hasError) {
      for (var article in newsModel.body.articles) {
        var articleEntity = article.toEntity();

        fetchedNewsIds.add(await db.insertNewsArticle(articleEntity));
      }
    }
    return fetchedNewsIds;
  }

  @override
  Future<List<NewsSourceEntity>> getNewsSources() async {
    String apiKey = await SecretLoader.getApiKey();

    final newsSources =
    await provider.getNewsSources("/sources?apiKey=$apiKey");
    if (!(newsSources.status.hasError)) {
      for (var source in newsSources.body.sources) {
        var sourceEntity = source.toEntity();

        await db.insertNewsSource(sourceEntity);
      }
    }
    var result = await db.getAllNewsSources();
    return result.map((map) => NewsSourceEntity().fromMap(map)).toList();
  }

  @override
  Future<NewsResponse> getNewsWithSource(String source) async {
    String apiKey = await SecretLoader.getApiKey();

    final news =
    await provider.getNews("/top-headlines?sources=$source&apiKey=$apiKey");
    if (news.status.hasError) {
      return Future.error(news.statusText);
    } else {
      return news.body;
    }
  }

  @override
  void updateBookmark(ArticleEntity articleEntity) async {
    if (articleEntity.isBookmarked == 0)
      articleEntity.isBookmarked = 1;
    else
      articleEntity.isBookmarked = 0;

    db.updateBookmarked(articleEntity);
  }

  Future<List<ArticleEntity>> getBookmarks() async {
    var result = await db.getBookmarkedNewsArticles();
    return result.map((map) => ArticleEntity().fromMap(map)).toList();
  }

  @override
  Future<NewsResponse> searchNews(String searchString) async {
    String apiKey = await SecretLoader.getApiKey();

    final news =
        await provider.getNews("/everything?q=$searchString&apiKey=$apiKey");
    if (news.status.hasError) {
      return Future.error(news.statusText);
    } else {
      print(news.body.articles);
      return news.body;
    }
  }
}
