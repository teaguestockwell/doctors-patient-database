import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Checkup{
  String
    uuid,
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
}): uuid = Uuid().v1();

Checkup.fromJson(Map<String, dynamic> json):
  uuid = json['uuid'], 
  patientid = json['patientid'] ?? '',
  doctor = json['doctor'] ?? '',
  datetime = json['datetime'] ?? '',
  systolicbp = json['systolicbp'] ?? '',
  heartrate = json['heartrate'] ?? '',
  weight = json['weight'] ?? '',
  height = json['height'] ?? '',
  medicines = json['medicines'] ?? '';

  Map<String, String> get toMap => {
    'uuid': uuid,
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
