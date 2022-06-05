import 'dart:async';

import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'models/news_response.dart';
import 'models/news_source_response.dart';

abstract class INewsProvider {
  Future<Response<NewsResponse>> getNews(String path);

  Future<Response<NewsSourceResponse>> getNewsSources(String path);

  Future<Response<NewsResponse>> searchNews(String path);
}

class NewsApiProvider extends GetConnect implements INewsProvider {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://newsapi.org/v2';
  }

  @override
  Future<Response<NewsResponse>> getNews(String path) {
    httpClient.defaultDecoder =
        (val) => NewsResponse.fromJson(val as Map<String, dynamic>);
    return get(path);
  }

  @override
  Future<Response<NewsSourceResponse>> getNewsSources(String path) {
    httpClient.defaultDecoder =
        (val) => NewsSourceResponse.fromJson(val as Map<String, dynamic>);
    return get(path);
  }

  Future<Response<NewsResponse>> searchNews(String path) {
    httpClient.defaultDecoder =
        (val) => NewsResponse.fromJson(val as Map<String, dynamic>);
    return get(path);
  }
}
