import 'dart:convert';
/// id : 2
/// game_id : 1
/// name : "SK grounds"
/// address_line1 : "Vandematram"
/// address_line2 : "Opp. SBI bank"
/// city : "ahmedabad"
/// state : "gujarat"
/// phone : 9988776655
/// profile_pic : "https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg"
/// offer_pics : null
/// ground_pics : null
/// pricing : null
/// slot_internval : 30
/// created_at : "2024-01-11T15:10:13"
/// updated_at : "2024-01-11T15:11:00"

LetsPlayApi letsPlayApiFromJson(String str) => LetsPlayApi.fromJson(json.decode(str));
String letsPlayApiToJson(LetsPlayApi data) => json.encode(data.toJson());
class LetsPlayApi {
  LetsPlayApi({
      num? id, 
      num? gameId, 
      String? name, 
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      String? state, 
      num? phone, 
      String? profilePic, 
      dynamic offerPics, 
      dynamic groundPics, 
      dynamic pricing, 
      num? slotinternval,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _gameId = gameId;
    _name = name;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
    _phone = phone;
    _profilePic = profilePic;
    _offerPics = offerPics;
    _groundPics = groundPics;
    _pricing = pricing;
    _slotinternval = slotinternval;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LetsPlayApi.fromJson(dynamic json) {
    _id = json['id'];
    _gameId = json['game_id'];
    _name = json['name'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
    _phone = json['phone'];
    _profilePic = json['profile_pic'];
    _offerPics = json['offer_pics'];
    _groundPics = json['ground_pics'];
    _pricing = json['pricing'];
    _slotinternval = json['slot_internval'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _gameId;
  String? _name;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  num? _phone;
  String? _profilePic;
  dynamic _offerPics;
  dynamic _groundPics;
  dynamic _pricing;
  num? _slotinternval;
  String? _createdAt;
  String? _updatedAt;
LetsPlayApi copyWith({  num? id,
  num? gameId,
  String? name,
  String? addressLine1,
  String? addressLine2,
  String? city,
  String? state,
  num? phone,
  String? profilePic,
  dynamic offerPics,
  dynamic groundPics,
  dynamic pricing,
  num? slotinternval,
  String? createdAt,
  String? updatedAt,
}) => LetsPlayApi(  id: id ?? _id,
  gameId: gameId ?? _gameId,
  name: name ?? _name,
  addressLine1: addressLine1 ?? _addressLine1,
  addressLine2: addressLine2 ?? _addressLine2,
  city: city ?? _city,
  state: state ?? _state,
  phone: phone ?? _phone,
  profilePic: profilePic ?? _profilePic,
  offerPics: offerPics ?? _offerPics,
  groundPics: groundPics ?? _groundPics,
  pricing: pricing ?? _pricing,
  slotinternval: slotinternval ?? _slotinternval,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get gameId => _gameId;
  String? get name => _name;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  String? get state => _state;
  num? get phone => _phone;
  String? get profilePic => _profilePic;
  dynamic get offerPics => _offerPics;
  dynamic get groundPics => _groundPics;
  dynamic get pricing => _pricing;
  num? get slotinternval => _slotinternval;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['game_id'] = _gameId;
    map['name'] = _name;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    map['phone'] = _phone;
    map['profile_pic'] = _profilePic;
    map['offer_pics'] = _offerPics;
    map['ground_pics'] = _groundPics;
    map['pricing'] = _pricing;
    map['slot_internval'] = _slotinternval;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}