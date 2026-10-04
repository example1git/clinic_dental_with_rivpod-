class UserDetails {
  final int id;
  final String? userID;
  final String role;
  final bool isActive;
  final DateTime? createAt;

  UserDetails({
    required this.id,
    this.userID,
    required this.role,
    this.createAt,
    this.isActive = true,
  });
}
