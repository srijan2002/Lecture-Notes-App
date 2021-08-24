class Role{
  String Role_Type;
  Role({this.Role_Type});

  Role.fromJson(Map<dynamic, dynamic> json)
      : Role_Type = json['role'];


  Map<dynamic, dynamic> toJson() => {
    'role': Role_Type,
  };
}
Role roll = Role();