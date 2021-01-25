import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Checkup{
  String
    checkupid,
    patientid,
    doctor,
    datetime,
    systolicbp,
    heartrate,
    weight,
    height,
    medicines;

static final numFields = 9;

Checkup({
  this.patientid = '',
  this.doctor = '',
  this.datetime = '',
  this.systolicbp = '',
  this.heartrate = '',
  this.weight = '',
  this.height = '',
  this.medicines = ''
}): checkupid = Uuid().v1();

Checkup.empty({
  this.checkupid = '',
  this.patientid = '',
  this.doctor = '',
  this.datetime = '',
  this.systolicbp = '',
  this.heartrate = '',
  this.weight = '',
  this.height = '',
  this.medicines = ''
}); 

Checkup.fromJson(Map<String, dynamic> json):
  checkupid = json['checkupid'], 
  patientid = json['patientid'] ?? '',
  doctor = json['doctor'] ?? '',
  datetime = json['datetime'] ?? '',
  systolicbp = json['systolicbp'] ?? '',
  heartrate = json['heartrate'] ?? '',
  weight = json['weight'] ?? '',
  height = json['height'] ?? '',
  medicines = json['medicines'] ?? '';

  Map<String, String> get toMap => {
    'checkupid': checkupid,
    'patientid': patientid ?? '',
    'doctor': doctor ?? '',
    'datetime': datetime ?? '',
    'systolicbp': systolicbp ?? '',
    'heartrate' :heartrate ?? '',
    'weight' :weight ?? '',
    'height': height ?? '',
    'medicines': medicines ?? ''
  };
}
