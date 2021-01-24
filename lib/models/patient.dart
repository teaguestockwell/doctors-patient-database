import 'package:flutter/foundation.dart';

class Patient{
  String 
    id,
    name,
    gender,
    dob,
    streetaddress,
    city,
    zipcode,
    state,
    phone,
    email,
    doctor,
    insurance;

  Patient({
    @required this.id,
    @required this.name,
    @required this.gender,
    @required this.dob,
    @required this.streetaddress,
    @required this.city,
    @required this.zipcode,
    @required this.state,
    @required this.phone,
    @required this.email,
    @required this.doctor,
    @required this.insurance,
  });

  Patient.fromJson(Map<String, dynamic> json):
    id = json['name'],
    name = json['name'],
    gender =json['gender'],
    dob = json['dob'],
    streetaddress = json['streetaddress'],
    city = json['city'],
    zipcode = json['zipcode'],
    state = json['state'],
    phone = json['phone'],
    email = json['email'],
    doctor = json['doctor'],
    insurance = json['insurance'];
}