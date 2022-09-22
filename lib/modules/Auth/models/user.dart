import 'dart:convert';


class AuthUser {
  String name;
  String uid;
  AuthUser({
    required this.name,
    required this.uid,
  });

  AuthUser copyWith({
    String? name,
    String? uid,
  }) {
    return AuthUser(
      name: name ?? this.name,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));

  @override
  String toString() => 'AuthUser(name: $name, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthUser && other.name == name && other.uid == uid;
  }

  @override
  int get hashCode => name.hashCode ^ uid.hashCode;
}
