import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/news_controller.dart';
import 'package:get/get.dart';

import 'news_item_view.dart';

class NewsListView extends GetView<NewsController> {
  final newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Container(child: newsController.obx(
      (articles) {
        return articles.length != 0
            ? RefreshIndicator(
                onRefresh: () {
                  return newsController.refreshNews();
                },
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 2,
                        child: NewsItem(articleEntity: articles[index]));
                  },
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    ));
  }
}
