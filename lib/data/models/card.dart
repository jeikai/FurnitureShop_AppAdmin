// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:furnitureshop_appadmin/data/models/bank.dart';

class Card {
  String id;
  String cardHolderName;
  String numberCard;
  String cardCVV;
  DateTime EXD;
  Bank? bank;
  Card({
    required this.id,
    required this.cardHolderName,
    required this.numberCard,
    required this.cardCVV,
    required this.EXD,
    this.bank,
  });

  Card copyWith({
    String? id,
    String? cardHolderName,
    String? numberCard,
    String? cardCVV,
    DateTime? EXD,
    Bank? bank,
  }) {
    return Card(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      numberCard: numberCard ?? this.numberCard,
      cardCVV: cardCVV ?? this.cardCVV,
      EXD: EXD ?? this.EXD,
      bank: bank ?? this.bank,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardHolderName': cardHolderName,
      'numberCard': numberCard,
      'cardCVV': cardCVV,
      'EXD': EXD.millisecondsSinceEpoch,
      'bank': bank?.toMap(),
    };
  }

  factory Card.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return Card(
      id: id,
      cardHolderName: map['cardHolderName'] as String,
      numberCard: map['numberCard'] as String,
      cardCVV: map['cardCVV'] as String,
      EXD: DateTime.fromMillisecondsSinceEpoch(map['EXD'] as int),
      bank: map['bank'] != null ? Bank.fromMap(map['bank'] as Map<String, dynamic>) : null,
    );
  }

  factory Card.template() {
    return Card(
      id: "id",
      cardHolderName: "",
      numberCard: "",
      cardCVV: "",
      EXD: DateTime.now(),
      bank: Bank.template(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Card(id: $id, cardHolderName: $cardHolderName, numberCard: $numberCard, cardCVV: $cardCVV, EXD: $EXD, bank: $bank)';
  }

  @override
  bool operator ==(covariant Card other) {
    if (identical(this, other)) return true;

    return other.id == id && other.cardHolderName == cardHolderName && other.numberCard == numberCard && other.cardCVV == cardCVV && other.EXD == EXD && other.bank == bank;
  }

  @override
  int get hashCode {
    return id.hashCode ^ cardHolderName.hashCode ^ numberCard.hashCode ^ cardCVV.hashCode ^ EXD.hashCode ^ bank.hashCode;
  }
}
