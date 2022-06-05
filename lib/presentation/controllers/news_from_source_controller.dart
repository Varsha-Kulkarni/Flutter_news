import 'package:flutter_newsapp/data/network/models/news_response.dart';
import 'package:flutter_newsapp/data/news_repository.dart';
import 'package:flutter_newsapp/domain/models/article_entity.dart';
import 'package:get/get.dart';

class NewsFromSourceController extends GetxController {
  final newsRepository = Get.find<INewsRepository>();
  String source = "";
  List<ArticleEntity> articles = [];

  @override
  void onInit() {
    super.onInit();

    getNewsList();
  }

  bool isEmpty() {
    if (articles.length == 0) return true;
    return false;
  }

  void getNewsList() async {
    var args = Get.arguments;
    source = args[0];
    NewsResponse newsList = await newsRepository.getNewsWithSource(source);
    for (var article in newsList.articles) {
      var articleEntity = article.toEntity();
      articles.add(articleEntity);
    }

    update();
  }
}
