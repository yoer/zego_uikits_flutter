// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class GiftProtocol {
  String senderID;
  String senderName;
  int giftID;
  int count;

  GiftProtocol({
    this.senderID = '',
    this.senderName = '',
    this.giftID = 1,
    this.count = 1,
  });

  void parseJson(String jsonData) {
    Map<dynamic, dynamic> commandMap = {};
    try {
      commandMap = json.decode(jsonData);
    } catch (e) {
      //
    }

    giftID = commandMap['gift_id'] as int? ?? 1;
    count = commandMap['count'] as int? ?? 1;
  }

  static Map<String, dynamic> toCommandMap(int giftID, int count) {
    return {'gift_id': giftID, 'count': count};
  }
}

class GiftModel {
  GiftModel({
    required this.id,
    required this.category,
    required this.type,
    required this.price,
  });

  bool get isEmpty => id < 0;

  GiftModel.empty()
      : id = -1,
        price = 1,
        category = GiftCategory.normal,
        type = GiftType.flower;

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      id: json['id'] as int,
      category: GiftCategory.values[json['category'] as int? ?? 1],
      type: GiftType.values[json['type'] as int? ?? 1],
      price: json['price'] as int? ?? 1,
    );
  }

  final int id;
  final GiftCategory category;
  final GiftType type;
  final int price;
}

enum GiftType {
  basketball,
  cheer,
  firework,
  flower,
  football,
  iLoveU,
  pingPang,
  rocket,
  rose,
  sportCar,
  sportCar2,
  sportShoe,
  trophy,
}

enum GiftCategory {
  normal,
  sport,
  children,
}

extension GiftCategoryExtension on GiftCategory {
  static GiftCategory fromInt(int type) {
    Map<int, GiftCategory> allCategoryType = {
      0: GiftCategory.normal,
      1: GiftCategory.sport,
      2: GiftCategory.children,
    };

    return allCategoryType[type] ?? GiftCategory.normal;
  }

  String get name {
    switch (this) {
      case GiftCategory.normal:
        return Translations.gift.categoryNormal;
      case GiftCategory.sport:
        return Translations.gift.categorySport;
      case GiftCategory.children:
        return Translations.gift.categoryChildren;
    }
  }
}

extension GiftTypeExtension on GiftType {
  static GiftType fromInt(int type) {
    Map<int, GiftType> allGiftType = {
      0: GiftType.basketball,
      1: GiftType.cheer,
      2: GiftType.firework,
      3: GiftType.flower,
      4: GiftType.football,
      5: GiftType.iLoveU,
      6: GiftType.pingPang,
      7: GiftType.rocket,
      8: GiftType.rose,
      9: GiftType.sportCar,
      10: GiftType.sportCar2,
      11: GiftType.sportShoe,
      12: GiftType.trophy,
    };

    return allGiftType[type] ?? GiftType.flower;
  }

  String get json {
    switch (this) {
      case GiftType.basketball:
        return 'basketball.json';
      case GiftType.cheer:
        return 'cheer.json';
      case GiftType.firework:
        return 'firework.json';
      case GiftType.flower:
        return 'flowers.json';
      case GiftType.football:
        return 'football.json';
      case GiftType.iLoveU:
        return 'iloveyou.json';
      case GiftType.pingPang:
        return 'ping_pang.json';
      case GiftType.rocket:
        return 'rocket.json';
      case GiftType.rose:
        return 'rose.json';
      case GiftType.sportCar:
        return 'sport_car.json';
      case GiftType.sportCar2:
        return 'sport_car_2.json';
      case GiftType.sportShoe:
        return 'sport_shoe.json';
      case GiftType.trophy:
        return 'trophy.json';
    }
  }

  String get asset {
    return 'assets/lottie/gifts/$json';
  }

  String get name {
    switch (this) {
      case GiftType.basketball:
        return 'basketball';
      case GiftType.cheer:
        return 'cheer';
      case GiftType.firework:
        return 'firework';
      case GiftType.flower:
        return 'flower';
      case GiftType.football:
        return 'football';
      case GiftType.iLoveU:
        return 'iLoveU';
      case GiftType.pingPang:
        return 'ping pang';
      case GiftType.rocket:
        return 'rocket';
      case GiftType.rose:
        return 'rose';
      case GiftType.sportCar:
        return 'sport car';
      case GiftType.sportCar2:
        return 'sport car';
      case GiftType.sportShoe:
        return 'sport shoe';
      case GiftType.trophy:
        return 'trophy';
    }
  }
}
