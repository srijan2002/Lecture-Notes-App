class File_Link{
  String name;
  File_Link({this.name});

  File_Link.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'];


  Map<dynamic, dynamic> toJson() => {
    'name': name,
  };
}
File_Link fil = File_Link();