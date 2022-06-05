import 'package:flutter_newsapp/data/news_repository.dart';
import 'package:flutter_newsapp/domain/models/news_source_entity.dart';
import 'package:get/get.dart';

class NewsSourcesController extends SuperController<List<NewsSourceEntity>> {
  // NewsSourcesController({this.newsRepository});

  final INewsRepository newsRepository = Get.put(NewsRepository());

  @override
  void onInit() {
    super.onInit();

    //Loading, Success, Error handle with 1 line of code
    append(() => newsRepository.getNewsSources);
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
