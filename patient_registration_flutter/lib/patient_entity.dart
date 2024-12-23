
class Patient {
  int? id;
  String firstName;
  String lastName;
  DateTime dob;
  int age;
  Gender gender;
  String? permanentAddress;
  String? presentAddress;
  String? mobileNo;
  String? image;

  Patient({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.age,
    required this.gender,
    this.permanentAddress,
    this.presentAddress,
    this.mobileNo,
    this.image,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as int?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dob: DateTime.parse(json['dob']),
      age: json['age'] as int,
      gender: Gender.values.firstWhere((e) => e.toString() == 'Gender.${json['gender']}'),
      permanentAddress: json['permanentAddress'] as String?,
      presentAddress: json['presentAddress'] as String?,
      mobileNo: json['mobileNo'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob.toIso8601String(),
      'age': age,
      'gender': gender.toString().split('.').last,
      'permanentAddress': permanentAddress,
      'presentAddress': presentAddress,
      'mobileNo': mobileNo,
      'image': image,
    };
  }
}

enum Gender {
  MALE,
  FEMALE,
  OTHERS,
}
