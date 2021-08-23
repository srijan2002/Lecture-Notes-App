
class Data{
     String Name; String Email; String Phone;
     Data({this.Name,this.Email,this.Phone});

     Data.fromJson(Map<String, dynamic> json)
         : Name = json['name'],
           Email = json['email'],
           Phone = json['phone'];


     Map<String, dynamic> toJson() => {
       'name': Name,
       'email': Email,
       'phone': Phone,
     };
}
Data user = Data();