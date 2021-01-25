import 'package:flutter/foundation.dart';

class Patient{
  String 
    id,
    name,
    gender,
    dob,
    street,
    city,
    zipcode,
    state,
    phone,
    email,
    doctor,
    insurance;

  static final numFields = 12;

  Patient({
    this.id = '',
    this.name = '',
    this.gender = '',
    this.dob = '',
    this.street = '',
    this.city = '',
    this.zipcode = '',
    this.state = '',
    this.phone = '',
    this.email = '',
    this.doctor = '',
    this.insurance = '',
  });

  Patient.fromJson(Map<String, dynamic> json):
    id = json['id'] ?? '',
    name = json['name'] ?? '',
    gender =json['gender'] ?? '',
    dob = json['dob'] ?? '',
    street = json['street'] ?? '',
    city = json['city'] ?? '',
    zipcode = json['zipcode'] ?? '',
    state = json['state'] ?? '',
    phone = json['phone'] ?? '',
    email = json['email'] ?? '',
    doctor = json['doctor'] ?? '',
    insurance = json['insurance'] ?? '';

  Map<String,String> get toMap => {
    'id': id ?? '',
    'name': name ?? '',
    'gender': gender ?? '',
    'dob': dob ?? '',
    'street': street ?? '',
    'city': city ?? '',
    'zipcode': zipcode ?? '',
    'state': state ?? '',
    'phone': phone ?? '',
    'email': email ?? '',
    'doctor': doctor ?? '',
    'insurance': insurance ?? ''
  };
}