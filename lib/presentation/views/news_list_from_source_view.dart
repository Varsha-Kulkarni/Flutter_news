import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/authentication_controller.dart';
import 'package:flutter_newsapp/presentation/controllers/news_from_source_controller.dart';
import 'package:flutter_newsapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'authentication_view.dart';

class NewsListFromSourceView extends GetView<NewsFromSourceController> {
  final authenticationController = Get.find<AuthenticationController>();
  final newsController = Get.put(NewsFromSourceController());

  Widget emptyList() {
    return Container(
      child: Center(
        child: Text(
          "No News from ${newsController.source}",
        ),
      ),
    );
  }

  Widget viewList() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ListView.builder(
          itemCount: newsController.articles.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            // return NewsItem(articleEntity: newsController.articles[index]);
            return Card(
                elevation: 2,
                child: GestureDetector(
                  onTap: () {
                    // launch(articleEntity.url);
                    Get.to(WebView(
                      initialUrl: newsController.articles[index].url,
                    ));
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                                child: Center(
                              child: CachedNetworkImage(
                                imageUrl:
                                    newsController.articles[index].urlToImage,
                                placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            )),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "Published:",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                dateFormatter(newsController
                                                    .articles[index]
                                                    .publishedAt),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                              ),
                                            ]),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "Source:",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                newsController
                                                    .articles[index].source,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                              ),
                                            ])
                                      ]),
                                ]),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              newsController.articles[index].title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              newsController.articles[index].description,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            )
                          ],
                        ),
                      )),
                ));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News from ${newsController.source}",
            overflow: TextOverflow.fade, maxLines: 1, softWrap: false),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                authenticationController.obx((state) => AuthenticationView(),
                    onError: authenticationController.signOut(),
                    onLoading:
                        const Center(child: const CircularProgressIndicator()));
              },
              child: Text("Logout"))
        ],
      ),
      body: GetBuilder<NewsFromSourceController>(
        builder: (_) => newsController.isEmpty() ? emptyList() : viewList(),
      ),
    );
  }
}
