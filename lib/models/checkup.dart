class Checkup{
  String
    patientid,
    doctor,
    datetime,
    systolicbp,
    heartrate,
    weight,
    height,
    medicines;

static final numFields = 8;

Checkup({
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
   patientid = json['patientid'] ?? '',
  doctor = json[''] ?? '',
  datetime = json[''] ?? '',
  systolicbp = json[''] ?? '',
  heartrate = json[''] ?? '',
  weight = json[''] ?? '',
  height = json[''] ?? '',
  medicines = json[''] ?? '';

  Map<String, String> get toMap => {
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
