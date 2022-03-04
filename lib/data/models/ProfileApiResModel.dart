/// status : 1
/// message : "Profile Details."
/// response : {"name":"Alam Food & Beverages","email":"alam@gmail.com","mobile":"9876543210","image":"https://mridayaitservices.com/demo/restobuy/uploads/user/img_1645705610.jpg","dob":"01-01-1970","gender":"Male","city":"Kolkata","country":"India"}

class ProfileApiResModel {
  ProfileApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  ProfileApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  int? _status;
  String? _message;
  Response? _response;

  int? get status => _status;
  String? get message => _message;
  Response? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }

}

/// name : "Alam Food & Beverages"
/// email : "alam@gmail.com"
/// mobile : "9876543210"
/// image : "https://mridayaitservices.com/demo/restobuy/uploads/user/img_1645705610.jpg"
/// dob : "01-01-1970"
/// gender : "Male"
/// city : "Kolkata"
/// country : "India"

class Response {
  Response({
      String? name, 
      String? email, 
      String? mobile, 
      String? image, 
      String? dob, 
      String? gender, 
      String? city, 
      String? country,}){
    _name = name;
    _email = email;
    _mobile = mobile;
    _image = image;
    _dob = dob;
    _gender = gender;
    _city = city;
    _country = country;
}

  Response.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _dob = json['dob'];
    _gender = json['gender'];
    _city = json['city'];
    _country = json['country'];
  }
  String? _name;
  String? _email;
  String? _mobile;
  String? _image;
  String? _dob;
  String? _gender;
  String? _city;
  String? _country;

  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get city => _city;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['city'] = _city;
    map['country'] = _country;
    return map;
  }

}