class Admin {
  String? name;
  String? avaUrl;
  String? email;
  String? code;
  String? phone;
  String? role;
  String? id;

  Admin({
    this.id = '',
    this.name = "",
    this.avaUrl = "",
    this.email = "",
    this.phone = '',
    this.code = '',
    this.role = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "email": email,
      "avatar": avaUrl,
      'code': code,
      'phone': phone,
      'role': role
    };
  }

  factory Admin.fromJson(Map<String, dynamic> data, String id) {
    return Admin(
      id: id,
      name: data['Name'] != null ? data['Name'] as String : null,
      email: data['email'] != null ? data['email'] as String : null,
      avaUrl: data['avatar'] != null ? data['avatar'] as String : null,
      code: data['code'] != null ? data['code'] as String : null,
      phone: data['phone'] != null ? data['phone'] as String : null,
      role: data['role'] != null ? data['role'] as String : null,
    );
  }
}
