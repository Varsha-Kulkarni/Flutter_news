import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp/domain/models/article_entity.dart';
import 'package:flutter_newsapp/presentation/controllers/news_controller.dart';
import 'package:flutter_newsapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsItem extends StatelessWidget {
  // final int index;
  final ArticleEntity articleEntity;

  NewsItem({this.articleEntity});

  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // launch(articleEntity.url);
          Get.to(WebView(
            initialUrl: articleEntity.url,
          ));
        },
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  child: Center(
                child: CachedNetworkImage(
                  imageUrl: getUrl(articleEntity.urlToImage),
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              )),
              SizedBox(
                height: 16,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Published: ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                Text(
                                  dateFormatter(articleEntity.publishedAt),
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Source: ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                Text(
                                  articleEntity.source,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ])
                        ]),
                    IconButton(
                      onPressed: () {
                        newsController.updateBookmark(articleEntity);
                      },
                      icon: Padding(
                          padding: EdgeInsets.zero,
                          child: articleEntity.isBookmarked == 1
                              ? Icon(
                                  Icons.bookmark,
                                )
                              : Icon(Icons.bookmark_outline)),
                    ),
                  ]),
              SizedBox(
                height: 8,
              ),
              Text(
                articleEntity.title,
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
                articleEntity.description ?? "",
                maxLines: 2,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              )
            ],
          ),
        ));
  }

  String getUrl(String urlToImage) {
    if (urlToImage == null) {
      return "https://picsum.photos/640/360";
    }
    return urlToImage;
  }
}
