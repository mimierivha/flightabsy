import 'package:flutter/material.dart';

final String url = 'https://jsonplaceholder.typicode.com/users';
class UserDetails {
  //final int id;
  final String Name,
      Country,
      City,
      iata;
  // profileUrl;

  // UserDetails({required this.id, required this.firstName, required this.lastName, this.profileUrl = 'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

  UserDetails({ required this.Name,required this.Country, required this.City,required this.iata});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      //id: json['id'],
        Name: json['name'],
        Country: json['country'],
        City: json['city'],
        iata: json['iata']
      //lastName: json['username'],
    );
  }
}