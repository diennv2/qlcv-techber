class UserProfile {
  final bool? status;
  final String? message;
  final num? tokenExpire;
  final String? displayName;
  final String? chucVuName;
  final String? phongBanName;
  final List<String>? role;
  final List<Permission>? permission;
  final String? token;
  final String? refreshToken;
  final num? userId;

  UserProfile({
    this.status,
    this.message,
    this.tokenExpire,
    this.displayName,
    this.chucVuName,
    this.phongBanName,
    this.role,
    this.permission,
    this.token,
    this.refreshToken,
    this.userId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        status: json['status'] == 'true',
        message: json['message'],
        tokenExpire: json['tokenExpire'],
        displayName: json['displayName'],
        chucVuName: json['chucVuName'],
        phongBanName: json['phongBanName'],
        role: json['role'] != null ? List<String>.from(json['role']) : null,
        permission: json['permission'] != null ? List<Permission>.from(json['permission'].map((x) => Permission.fromJson(x))) : null,
        token: json['token'],
        refreshToken: json['refreshToken'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'status': status == true ? 'true' : 'false',
        'message': message,
        'tokenExpire': tokenExpire,
        'displayName': displayName,
        'chucVuName': chucVuName,
        'phongBanName': phongBanName,
        'role': role != null ? List<dynamic>.from(role!.map((x) => x)) : null,
        'permission': permission != null ? List<dynamic>.from(permission!.map((x) => x.toJson())) : null,
        'token': token,
        'refreshToken': refreshToken,
        'userId': userId,
      };
}

class Permission {
  final String? permission;
  final String? description;

  Permission({
    this.permission,
    this.description,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        permission: json['permission'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'permission': permission,
        'description': description,
      };
}
