class Student {
  int registrationMainId;
  final String userCode;
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String phoneCountryCode;
  final String email;
  String createdTime;

  Student({
    required this.registrationMainId,
    required this.userCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.phoneCountryCode,
    required this.email,
    required this.createdTime,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      registrationMainId: int.parse(json['registration_main_id']),
      userCode: json['user_code'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      phoneCountryCode: json['phone_country_code'],
      email: json['email'],
      createdTime: json['created_time'],
    );
  }

  Student copyWith({
    required int registrationMainId,
    required String userCode,
    required String firstName,
    required String middleName,
    required String lastName,
    required String phoneNumber,
    required String phoneCountryCode,
    required String email,
    required String createdTime,
  }) {
    return Student(
      registrationMainId: registrationMainId,
      userCode: userCode,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      phoneCountryCode: phoneCountryCode,
      email: email,
      createdTime: createdTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registration_main_id': registrationMainId,
      'user_code': userCode,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'phone_country_code': phoneCountryCode,
      'email': email,
      'created_time': createdTime,
    };
  }
}
