import 'package:flutter_newsapp/data/network/models/news_response.dart';
import 'package:flutter_newsapp/data/news_repository.dart';
import 'package:flutter_newsapp/domain/models/article_entity.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final newsRepository = Get.find<INewsRepository>();
  String searchText = "";
  List<ArticleEntity> articles;

  @override
  void onInit() {
    super.onInit();

    getNewsList();
  }

  bool isEmpty() {
    if (articles != null) {
      if (articles.length == 0) return true;
    }
    return false;
  }

  void getNewsList() async {
    var args = Get.arguments;
    searchText = args[0];
    List<ArticleEntity> result = [];
    NewsResponse newsList = await newsRepository.searchNews(searchText);
    int count = 0;
    for (var article in newsList.articles) {
      var articleEntity = article.toEntity();
      result.add(articleEntity);
      count++;
      if (count == 20) break;
    }
    articles = result;

    update();
  }
}
