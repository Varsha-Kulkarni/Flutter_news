import 'package:flutter_newsapp/data/news_repository.dart';
import 'package:flutter_newsapp/domain/models/article_entity.dart';
import 'package:get/get.dart';

class NewsController extends SuperController<List<ArticleEntity>> {
  final INewsRepository newsRepository = Get.put(NewsRepository());
  List<ArticleEntity> bookmarks = [];

  @override
  void onInit() {
    super.onInit();

    refreshNews();
    append(() => newsRepository.getNews);
    getBookmarkedArticles();
    update();
  }

  Future<void> refreshNews() async {
    var newsIds = await newsRepository.refreshNews();
    if (newsIds.length > 0) {
      append(() => newsRepository.getNews);
    }
    update();
  }

  void updateBookmark(ArticleEntity articleEntity) {
    newsRepository.updateBookmark(articleEntity);
    getBookmarkedArticles();
    append(() => newsRepository.getNews);
    update();
  }

  bool isEmpty() {
    if (bookmarks.length == 0) return true;
    return false;
  }

  void getBookmarkedArticles() async {
    bookmarks = await newsRepository.getBookmarks();
    update();
  }

  @override
  void onDetached() {
    print('onDetached called');
  }

  @override
  void onInactive() {
    print('onInative called');
  }

  @override
  void onPaused() {
    print('onPaused called');
  }

  @override
  void onResumed() {
    print('onResumed called');
  }
}
