import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/news_controller.dart';
import 'package:get/get.dart';

import 'news_item_view.dart';

class BookmarksView extends GetView<NewsController> {
  final newsController = Get.find<NewsController>();

  Widget emptyList() {
    return Container(
      child: Center(
        child: Text(
          "No Bookmarks! start saving News articles to read later.",
        ),
      ),
    );
  }

  Widget viewList() {
    return Container(child: newsController.obx((articles) {
      return ListView.builder(
        itemCount: newsController.bookmarks.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
              elevation: 2,
              child: NewsItem(articleEntity: newsController.bookmarks[index]));
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (_) => newsController.isEmpty() ? emptyList() : viewList(),
    );
  }
}
