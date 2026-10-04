class Patient {
  final String id;
  final String? userID;
  final String fullName;
  final String phone;
  final DateTime? createdAt;

  Patient({
    required this.id,
    this.userID,
    required this.fullName,
    required this.phone,
    this.createdAt,
  });
}
