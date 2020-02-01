import 'package:eschlen_guide/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eschlen_guide/location.dart';
import 'dart:math';

class RecommendedData extends ChangeNotifier {

  Map recommenedData = Map();

  final _key = 'KakaoAK ';
  final List _resKeywords = [
    '중식',
    '양식',
    '일식',
    '고기',
    '쌈밥',
    '국밥',
    '해물요리',
    '국수',
    '냉면',
    '해장국',
    '순대',
    '찌개',
    '한정식',
    '감자탕',
    '주먹밥',
    '퓨전요리',
    '아시아음식',
    '분식',
    '치킨',
    '패스트푸드',
    '간식',
    '도시락'
  ];

  Future<bool> getRestaurants(options) async {
    Map filteredRestaurantData;
    bool isEnd = false;
    double x, y;
    int page, radius;
    List keywords = [];
    String query = '음식점';
    List<Map> restaurantData = [];
    Set restaurantName = Set();

    try {
      Map location = await Location().getCurrentLocation();
      x = location['longitude'];
      y = location['latitude'];
    } catch (e) {
      x = 126.837846;
      y = 37.300436;
    }

    radius = 700;

    for (var v in options.keys) {
      if (options[v]) {
        if (v == 'random') {
          continue;
        } else if (v == 'nearest') {
          radius = 500;
        } else if (v == 'chinese') {
          keywords.add('중식');
        } else if (v == 'japanese') {
          keywords.add('일식');
        } else if (v == 'liquor') {
          keywords.add('술집');
        } else if (v == 'cafe') {
          keywords.add('커피전문점');
        }
      }
    }

    if (!keywords.contains('술집') &&
        !keywords.contains('커피전문점') &&
        !keywords.contains('중식') &&
        !keywords.contains('일식')) {
      for (String res in _resKeywords) {
        keywords.add(res);
      }
    }
    for (String keyword in keywords) {
      query = keyword;
      page = 1;
      do {
        NetworkHelper networkHelper = NetworkHelper(
            url:
                "https://dapi.kakao.com/v2/local/search/keyword.json?query=$query&y=$y&x=$x&radius=$radius&page=$page",
            key: _key);
        var mapData = await networkHelper.getData();
        if (mapData == {}) {
          break;
        }
        for (var data in mapData['documents']) {
          if (!restaurantName.contains(data['place_name'])) {
            restaurantName.add(data['place_name']);
            restaurantData.add(data);
          }
        }
        isEnd = mapData['meta']['is_end'];
        page += 1;
      } while (!isEnd);
    }

    if (restaurantData.length == 0) {
      filteredRestaurantData = {
        'url': ''
      };
    } else {
      restaurantData.shuffle();
      filteredRestaurantData =
          restaurantData[Random().nextInt(restaurantData.length)];
    }

    recommenedData = filteredRestaurantData;

    return filteredRestaurantData != {} ? true : false;
  }
}
