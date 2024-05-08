import 'dart:convert';
/// id : 3
/// game_id : 1
/// name : "Powerplay Box Cricket"
/// address_line1 : "Shilaj Road,"
/// address_line2 : "(Opposite Swagat Bagan Villa)"
/// city : "Ahmedabad "
/// state : "Gujarat"
/// phone : 7041841692
/// profile_pic : "https://lh3.googleusercontent.com/p/AF1QipOJEbVNY5XReVWweytpjIUYbbM9B1s2gOI-mUHG=s1360-w1360-h1020"
/// offer_pics : {"photos":["https://lh3.googleusercontent.com/p/AF1QipNfPon2F4rJCvORfhSAxs72JFb7zSdp6kkshCI5=s1360-w1360-h1020","https://lh3.googleusercontent.com/p/AF1QipPV_luwXug_XR5RvQLFingS-7_PVXEH4vuqduoG=s1360-w1360-h1020"]}
/// ground_pics : null
/// pricing : null
/// slotinternval : 120
/// created_at : "2024-02-02T13:15:03"
/// updated_at : "2024-02-02T13:14:55"
/// created_by : "5c04ecda-a880-4cc6-9b96-08af8d029ca6"

LetsPlay letsPlayFromJson(String str) => LetsPlay.fromJson(json.decode(str));
String letsPlayToJson(LetsPlay data) => json.encode(data.toJson());
class LetsPlay {
  LetsPlay({
      num? id, 
      num? gameId, 
      String? name, 
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      String? state, 
      num? phone, 
      String? profilePic, 
      OfferPics? offerPics, 
      dynamic groundPics, 
      dynamic pricing, 
      num? slotinternval, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy,}){
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
    _createdBy = createdBy;
}

  LetsPlay.fromJson(dynamic json) {
    _id = json['id'];
    _gameId = json['game_id'];
    _name = json['name'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
    _phone = json['phone'];
    _profilePic = json['profile_pic'];
    _offerPics = json['offer_pics'] != null ? OfferPics.fromJson(json['offer_pics']) : null;
    _groundPics = json['ground_pics'];
    _pricing = json['pricing'];
    _slotinternval = json['slotinternval'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
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
  OfferPics? _offerPics;
  dynamic _groundPics;
  dynamic _pricing;
  num? _slotinternval;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
LetsPlay copyWith({  num? id,
  num? gameId,
  String? name,
  String? addressLine1,
  String? addressLine2,
  String? city,
  String? state,
  num? phone,
  String? profilePic,
  OfferPics? offerPics,
  dynamic groundPics,
  dynamic pricing,
  num? slotinternval,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
}) => LetsPlay(  id: id ?? _id,
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
  createdBy: createdBy ?? _createdBy,
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
  OfferPics? get offerPics => _offerPics;
  dynamic get groundPics => _groundPics;
  dynamic get pricing => _pricing;
  num? get slotinternval => _slotinternval;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;

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
    if (_offerPics != null) {
      map['offer_pics'] = _offerPics?.toJson();
    }
    map['ground_pics'] = _groundPics;
    map['pricing'] = _pricing;
    map['slotinternval'] = _slotinternval;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    return map;
  }

}

/// photos : ["https://lh3.googleusercontent.com/p/AF1QipNfPon2F4rJCvORfhSAxs72JFb7zSdp6kkshCI5=s1360-w1360-h1020","https://lh3.googleusercontent.com/p/AF1QipPV_luwXug_XR5RvQLFingS-7_PVXEH4vuqduoG=s1360-w1360-h1020"]

OfferPics offerPicsFromJson(String str) => OfferPics.fromJson(json.decode(str));
String offerPicsToJson(OfferPics data) => json.encode(data.toJson());
class OfferPics {
  OfferPics({
      List<String>? photos,}){
    _photos = photos;
}

  OfferPics.fromJson(dynamic json) {
    _photos = json['photos'] != null ? json['photos'].cast<String>() : [];
  }
  List<String>? _photos;
OfferPics copyWith({  List<String>? photos,
}) => OfferPics(  photos: photos ?? _photos,
);
  List<String>? get photos => _photos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photos'] = _photos;
    return map;
  }

}