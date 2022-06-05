import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:flutter/services.dart' show rootBundle;

class Secret {
  final String apiKey;

  Secret({this.apiKey = ""});

  factory Secret.fromJson(Map<String, dynamic> json) {
    return new Secret(apiKey: json['api_key']);
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (value) async {
      return Secret.fromJson(json.decode(value));
    });
  }

  static Future<String> getApiKey() async {
    return await SecretLoader(secretPath: "assets/secret.json")
        .load()
        .then((value) => value.apiKey);
  }
}
