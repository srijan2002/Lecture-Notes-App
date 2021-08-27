class Video_Link{
  String name;
  Video_Link({this.name});

  Video_Link.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'];


  Map<dynamic, dynamic> toJson() => {
    'name': name,
  };
}
Video_Link vid = Video_Link();