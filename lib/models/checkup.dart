class Checkup{
  String
    id,
    doctor,
    datetime,
    systolicbp,
    heartrate,
    weight,
    height,
    medicines;

static final numFields = 8;

Checkup({
  this.id = '',
  this.doctor = '',
  this.datetime = '',
  this.systolicbp = '',
  this.heartrate = '',
  this.weight = '',
  this.height = '',
  this.medicines = ''
});

Checkup.fromJson(Map<String, dynamic> json):
  id = json['id'] ?? '',
  doctor = json['doctor'] ?? '',
  datetime = json['datetime'] ?? '',
  systolicbp = json['systolicbp'] ?? '',
  heartrate = json['heartrate'] ?? '',
  weight = json['weight'] ?? '',
  height = json['height'] ?? '',
  medicines = json['medicines'] ?? '';

  Map<String, String> get toMap => {
    'id': id ?? '',
    'doctor': doctor ?? '',
    'datetime': datetime ?? '',
    'systolicbp': systolicbp ?? '',
    'heartrate' :heartrate ?? '',
    'weight' :weight ?? '',
    'height': height ?? '',
    'medicines': medicines ?? ''
  };
}
