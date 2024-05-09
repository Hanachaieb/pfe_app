class Cusers {
  String uid;
  String fullName;
  String email;
  String? token;
  String? occupation;
  String? gsm;
  String? facebook;
  String? desc;
  String? adresse;
  String role;

  Cusers({
    required this.fullName,
    required this.email,
    required this.uid,
    required this.role,
    this.token,
    this.occupation,
    this.facebook,
    this.desc,
    this.gsm,
    this.adresse,
  });

  factory Cusers.fromJson(Map<String, dynamic> json) {
    return Cusers(
      fullName: json['fullName'],
      email: json['email'],
      uid: json['uid'],
      role: json['role'],
      token: json['token'],
      gsm: json['gsm'],
      occupation: json['occupation'],
      facebook: json['facebook'],
      desc: json['desc'],
      adresse: json['adresse'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['uid'] = this.uid;
    if (this.occupation != null) data['occupation'] = this.occupation;
    if (this.token != null) data['token'] = this.token;
    if (this.gsm != null) data['gsm'] = this.gsm;
    if (this.facebook != null) data['facebook'] = this.facebook;
    if (this.desc != null) data['desc'] = this.desc;
    if (this.adresse != null) data['adresse'] = this.adresse;
    return data;
  }
}
