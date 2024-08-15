import 'package:cloud_firestore/cloud_firestore.dart';

class MyDiscount {
  String? id;
  String? name;
  String? imageNetwork;
  DateTime? timeStart;
  DateTime? timeEnd;
  int? number;
  int? percent;
  double? priceStart;
  double? priceLimit;
  bool isOffline;
  bool isOnline;
  bool isGame;
  String codeStore;
  int score;
  MyDiscount({
    this.id,
    this.name,
    this.imageNetwork,
    this.timeStart,
    this.timeEnd,
    this.number,
    this.percent,
    this.priceStart,
    this.priceLimit,
    this.codeStore = "",
    this.score = 0,
    this.isOffline = false,
    this.isOnline = false,
    this.isGame = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image_network": imageNetwork,
      "time_start": (timeStart != null) ? Timestamp.fromDate(timeStart!) : null,
      "time_end": (timeEnd != null) ? Timestamp.fromDate(timeEnd!) : null,
      "number": number,
      "percent": percent,
      "price_start": priceStart,
      "price_limit": priceLimit,
      "code_store": codeStore,
      "score_game": score,
      "is_offline": isOffline,
      "is_online": isOnline,
      "is_game": isGame,
    };
  }

  factory MyDiscount.fromJson(Map<String, dynamic> data, String? id) {
    return MyDiscount(
      id: id,
      name: data["name"],
      imageNetwork: data["image_network"],
      timeStart: DateTime.tryParse((data["time_start"] as Timestamp).toDate().toString()),
      timeEnd: DateTime.tryParse((data["time_end"] as Timestamp).toDate().toString()),
      number: data["number"],
      percent: data["percent"],
      priceStart: data["price_start"],
      priceLimit: data["price_limit"],
      codeStore: data["code_store"],
      score: data["score_game"],
      isOffline: data['is_offline'] != null ? data['is_offline'] as bool : false,
      isOnline: data['is_online'] != null ? data['is_online'] as bool : false,
      isGame: data['is_game'] != null ? data['is_game'] as bool : false,
    );
  }
}
