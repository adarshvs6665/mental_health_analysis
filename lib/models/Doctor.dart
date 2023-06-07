class Doctor {
  final String doctorId;
  final String name;
  final String email;

  Doctor({
    required this.doctorId,
    required this.name,
    required this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctorId'],
      name: json['name'],
      email: json['email'],
    );
  }
}
