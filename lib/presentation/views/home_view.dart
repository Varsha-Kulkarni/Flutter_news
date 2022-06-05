import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/authentication_controller.dart';
import 'package:flutter_newsapp/presentation/controllers/home_controller.dart';
import 'package:flutter_newsapp/presentation/views/bookmarks_view.dart';
import 'package:flutter_newsapp/presentation/views/news_list_view.dart';
import 'package:flutter_newsapp/presentation/views/search_view.dart';
import 'package:get/get.dart';

import 'authentication_view.dart';
import 'news_sources_list_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget appBarTitle = new Text("News App");
  Icon actionIcon = new Icon(Icons.search);
  final AuthenticationController authenticationController = Get.find();
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    onSubmitted: handleTextInputSubmit,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search News",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("News App");
                }
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleOverflowMenuClicks,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(
              text: "News",
            ),
            Tab(text: "News Sources"),
            Tab(text: "Bookmarks"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [NewsListView(), NewsSourcesListView(), BookmarksView()],
      ),
    );
  }

  void handleOverflowMenuClicks(String value) {
    switch (value) {
      case 'Logout':
        authenticationController.obx((state) => HomeView(),
            onError: handleError(),
            onLoading: const Center(child: const CircularProgressIndicator()));
        break;
    }
  }

  void handleTextInputSubmit(var input) {
    if (input != '') {
      Get.to(() => SearchView(),
          arguments: [input], transition: Transition.fadeIn);
    }
  }

  handleError() {
    Get.offAll(AuthenticationView());
    authenticationController.signOut();
  }
}
