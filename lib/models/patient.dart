import 'package:uuid/uuid.dart';

class Patient{
  String 
    patientid,
    ssn,
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

  static final numFields = 13;

  Patient({
    this.ssn ='',
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
  }): patientid = Uuid().v1();

  Patient.fromJson(Map<String, dynamic> json):
    patientid = json['patientid'],
    ssn = json['ssn'],
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
    'patientid': patientid ?? '',
    'ssn': ssn ?? '',
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