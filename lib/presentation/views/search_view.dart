import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/authentication_controller.dart';
import 'package:flutter_newsapp/presentation/controllers/search_controller.dart';
import 'package:flutter_newsapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchView extends GetView<SearchController> {
  final authenticationController = Get.find<AuthenticationController>();
  final searchController = Get.put(SearchController());

  Widget emptyList() {
    return Container(
      child: Center(
        child: Text(
          "No results found for ${searchController.searchText}",
        ),
      ),
    );
  }

  Widget viewList() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ListView.builder(
          itemCount: searchController.articles.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: GestureDetector(
                  onTap: () {
                    // launch(articleEntity.url);
                    Get.to(WebView(
                      initialUrl: searchController.articles[index].url,
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                            child: Center(
                          child: CachedNetworkImage(
                            imageUrl:
                                searchController.articles[index].urlToImage,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            dateFormatter(searchController
                                                .articles[index].publishedAt),
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
                                            searchController
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
                          searchController.articles[index].title,
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
                          searchController.articles[index].description,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        )
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${searchController.searchText}",
            overflow: TextOverflow.fade, maxLines: 1, softWrap: false),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: authenticationController.signOut,
              child: Text("Logout"))
        ],
      ),
      body: GetBuilder<SearchController>(
        builder: (_) => searchController.articles == null
            ? const Center(child: const CircularProgressIndicator())
            : searchController.isEmpty()
                ? emptyList()
                : viewList(),
      ),
    );
  }
}
