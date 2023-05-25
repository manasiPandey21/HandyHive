// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:handyhive/Models/users.dart';

class Users {
  final String uidUser;
  final String nameUser;
  final String ageUser;
  final String genderUser;
  final String mobileNumberUser;
  final String addressUser;
  final String religionUser;
  final String numberOfPeopleInhouseUser;
  final Map<String, String> acceptedRequests;
  Users({
    required this.uidUser,
    required this.nameUser,
    required this.ageUser,
    required this.genderUser,
    required this.mobileNumberUser,
    required this.addressUser,
    required this.religionUser,
    required this.numberOfPeopleInhouseUser,
    required this.acceptedRequests,
  });

  Users copyWith({
    String? uidUser,
    String? nameUser,
    String? ageUser,
    String? genderUser,
    String? mobileNumberUser,
    String? addressUser,
    String? religionUser,
    String? numberOfPeopleInhouseUser,
    Map<String, String>? acceptedRequests,
  }) {
    return Users(
      uidUser: uidUser ?? this.uidUser,
      nameUser: nameUser ?? this.nameUser,
      ageUser: ageUser ?? this.ageUser,
      genderUser: genderUser ?? this.genderUser,
      mobileNumberUser: mobileNumberUser ?? this.mobileNumberUser,
      addressUser: addressUser ?? this.addressUser,
      religionUser: religionUser ?? this.religionUser,
      numberOfPeopleInhouseUser: numberOfPeopleInhouseUser ?? this.numberOfPeopleInhouseUser,
      acceptedRequests: acceptedRequests ?? this.acceptedRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidUser': uidUser,
      'nameUser': nameUser,
      'ageUser': ageUser,
      'genderUser': genderUser,
      'mobileNumberUser': mobileNumberUser,
      'addressUser': addressUser,
      'religionUser': religionUser,
      'numberOfPeopleInhouseUser': numberOfPeopleInhouseUser,
      'acceptedRequests': acceptedRequests,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      uidUser: map['uidUser'] as String,
      nameUser: map['nameUser'] as String,
      ageUser: map['ageUser'] as String,
      genderUser: map['genderUser'] as String,
      mobileNumberUser: map['mobileNumberUser'] as String,
      addressUser: map['addressUser'] as String,
      religionUser: map['religionUser'] as String,
      numberOfPeopleInhouseUser: map['numberOfPeopleInhouseUser'] as String,
      acceptedRequests: Map<String, String>.from((map['acceptedRequests'] as Map<String,dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(uidUser: $uidUser, nameUser: $nameUser, ageUser: $ageUser, genderUser: $genderUser, mobileNumberUser: $mobileNumberUser, addressUser: $addressUser, religionUser: $religionUser, numberOfPeopleInhouseUser: $numberOfPeopleInhouseUser, acceptedRequests: $acceptedRequests)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;
  
    return 
      other.uidUser == uidUser &&
      other.nameUser == nameUser &&
      other.ageUser == ageUser &&
      other.genderUser == genderUser &&
      other.mobileNumberUser == mobileNumberUser &&
      other.addressUser == addressUser &&
      other.religionUser == religionUser &&
      other.numberOfPeopleInhouseUser == numberOfPeopleInhouseUser &&
      mapEquals(other.acceptedRequests, acceptedRequests);
  }

  @override
  int get hashCode {
    return uidUser.hashCode ^
      nameUser.hashCode ^
      ageUser.hashCode ^
      genderUser.hashCode ^
      mobileNumberUser.hashCode ^
      addressUser.hashCode ^
      religionUser.hashCode ^
      numberOfPeopleInhouseUser.hashCode ^
      acceptedRequests.hashCode;
  }
}
