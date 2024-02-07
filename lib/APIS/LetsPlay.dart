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
/// offer_pics : {"photos":["https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg","https://5.imimg.com/data5/ANDROID/Default/2021/1/MJ/HS/RL/118190257/product-jpeg.jpg"]}
/// ground_pics : {"photos":["https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg","https://5.imimg.com/data5/ANDROID/Default/2021/1/MJ/HS/RL/118190257/product-jpeg.jpg"]}
/// pricing : {"photos":["https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg","https://5.imimg.com/data5/ANDROID/Default/2021/1/MJ/HS/RL/118190257/product-jpeg.jpg"]}
/// slot_internval : 30
/// created_at : "2024-01-11T15:10:13"
/// updated_at : "2024-01-11T15:11:00"

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
      GroundPics? groundPics, 
      Pricing? pricing, 
      num? slotInternval, 
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
    _slotInternval = slotInternval;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
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
    _groundPics = json['ground_pics'] != null ? GroundPics.fromJson(json['ground_pics']) : null;
    _pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    _slotInternval = json['slotinternval'];
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
  OfferPics? _offerPics;
  GroundPics? _groundPics;
  Pricing? _pricing;
  num? _slotInternval;
  String? _createdAt;
  String? _updatedAt;
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
  GroundPics? groundPics,
  Pricing? pricing,
  num? slotInternval,
  String? createdAt,
  String? updatedAt,
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
  slotInternval: slotInternval ?? _slotInternval,
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
  OfferPics? get offerPics => _offerPics;
  GroundPics? get groundPics => _groundPics;
  Pricing? get pricing => _pricing;
  num? get slotInternval => _slotInternval;
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
    if (_offerPics != null) {
      map['offer_pics'] = _offerPics?.toJson();
    }
    if (_groundPics != null) {
      map['ground_pics'] = _groundPics?.toJson();
    }
    if (_pricing != null) {
      map['pricing'] = _pricing?.toJson();
    }
    map['slotinternval'] = _slotInternval;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// photos : ["https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg","https://5.imimg.com/data5/ANDROID/Default/2021/1/MJ/HS/RL/118190257/product-jpeg.jpg"]

Pricing pricingFromJson(String str) => Pricing.fromJson(json.decode(str));
String pricingToJson(Pricing data) => json.encode(data.toJson());
class Pricing {
  Pricing({
      List<String>? photos,}){
    _photos = photos;
}

  Pricing.fromJson(dynamic json) {
    _photos = json['photos'] != null ? json['photos'].cast<String>() : [];
  }
  List<String>? _photos;
Pricing copyWith({  List<String>? photos,
}) => Pricing(  photos: photos ?? _photos,
);
  List<String>? get photos => _photos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photos'] = _photos;
    return map;
  }

}

/// photos : ["https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg","https://5.imimg.com/data5/ANDROID/Default/2021/1/MJ/HS/RL/118190257/product-jpeg.jpg"]

GroundPics groundPicsFromJson(String str) => GroundPics.fromJson(json.decode(str));
String groundPicsToJson(GroundPics data) => json.encode(data.toJson());
class GroundPics {
  GroundPics({
      List<String>? photos,}){
    _photos = photos;
}

  GroundPics.fromJson(dynamic json) {
    _photos = json['photos'] != null ? json['photos'].cast<String>() : [];
  }
  List<String>? _photos;
GroundPics copyWith({  List<String>? photos,
}) => GroundPics(  photos: photos ?? _photos,
);
  List<String>? get photos => _photos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photos'] = _photos;
    return map;
  }

}

/// photos : ["https://5.imimg.com/data5/ANDROID/Default/2023/3/296174866/ET/MV/DT/25720420/product-jpeg.jpg","https://5.imimg.com/data5/ANDROID/Default/2021/1/MJ/HS/RL/118190257/product-jpeg.jpg"]

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