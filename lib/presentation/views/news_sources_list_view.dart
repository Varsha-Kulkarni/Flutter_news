import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/news_controller.dart';
import 'package:flutter_newsapp/presentation/controllers/news_sources_controller.dart';
import 'package:get/get.dart';

import 'news_list_from_source_view.dart';

class NewsSourcesListView extends GetView<NewsController> {
  final newsSourcesController = Get.put(NewsSourcesController());

  @override
  Widget build(BuildContext context) {
    return Container(child: newsSourcesController.obx((sources) {
      return ListView.builder(
          itemCount: sources.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
                elevation: 1,
                child: NewsSourcesItem(
                  name: sources[index].name ?? "",
                  description: sources[index].description ?? "",
                  category: sources[index].category ?? "",
                  country: sources[index].country ?? "",
                  url: sources[index].url ?? "",
                ));
          });
    }));
  }
}

class NewsSourcesItem extends StatelessWidget {
  final String name, description, category, country, url;

  NewsSourcesItem(
      {this.name, this.description, this.category, this.country, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsListFromSourceView(),
            arguments: [name], transition: Transition.fadeIn);
        // Get.to(WebView(
        //   initialUrl: url,
        // ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              name,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Category: ",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                    category,
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Country: ",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                    country,
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ]),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              description,
              maxLines: 3,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
