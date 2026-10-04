import 'package:mysen/features/auth/domain/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  UserDetailsModel({required super.id, required super.role});
  UserDetailsModel copyWith({int? id, String? role, DateTime? createAt}) {
    return UserDetailsModel(id: id ?? this.id, role: role ?? this.role);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'role': role};
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      id: map['id'] as int,
      role: map['role'] as String,
      // createAt: map['createAt'] != null
      //     ? DateTime.parse(map['createAt'])
      //     : null,
    );
  }
}
