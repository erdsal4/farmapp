import 'dart:collection';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Site.dart';
import '../main.dart';

enum SiteLoadingStatus { NotLoaded, Loading, Loaded, Error }

class SiteProvider extends ChangeNotifier {

  List<Site> sites;
  SiteLoadingStatus _siteLoadingStatus = SiteLoadingStatus.Loading;

  SiteLoadingStatus get status => _siteLoadingStatus;
  
  Future<void> fetchSites(jwt) async {

    print("fetchingsits");
    final Map<String,String> headers = {
      "x-access-token": jwt
    };
    final response = await http.get('$SERVER_DOMAIN/sites', headers: headers);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      sites = List<Site>.from(l.map((i) => Site.fromJson(i)));
      _siteLoadingStatus = SiteLoadingStatus.Loaded;
      notifyListeners();
    } else {
      _siteLoadingStatus = SiteLoadingStatus.Error;
    }
    
  }
  
}
