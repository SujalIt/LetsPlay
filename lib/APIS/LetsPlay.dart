class LetsPlay {
  LetsPlay({
    num? id,
    String? name,
    String? addressLine1,
    String? addressLine2,
    String? city,
    num? phone,
    String? profilePic,
    OfferPics? offerPics,
    num? pricing,
    num? slotinternval,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? groundLocation,
  }) {
    _id = id;
    _name = name;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _phone = phone;
    _profilePic = profilePic;
    _offerPics = offerPics;
    _pricing = pricing;
    _slotinternval = slotinternval;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _groundLocation = groundLocation;
  }

  LetsPlay.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _phone = json['phone'];
    _profilePic = json['profile_pic'];
    _offerPics = json['offer_pics'] != null
        ? OfferPics.fromJson(json['offer_pics'])
        : null;
    _pricing = json['pricing'];
    _slotinternval = json['slotinternval'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _groundLocation = json['ground_location'];
  }
  num? _id;
  String? _name;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  num? _phone;
  String? _profilePic;
  OfferPics? _offerPics;
  num? _pricing;
  num? _slotinternval;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _groundLocation;
  LetsPlay copyWith({
    num? id,
    String? name,
    String? addressLine1,
    String? addressLine2,
    String? city,
    num? phone,
    String? profilePic,
    OfferPics? offerPics,
    dynamic groundPics,
    num? pricing,
    num? slotinternval,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? groundLocation,
  }) =>
      LetsPlay(
        id: id ?? _id,
        name: name ?? _name,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        city: city ?? _city,
        phone: phone ?? _phone,
        profilePic: profilePic ?? _profilePic,
        offerPics: offerPics ?? _offerPics,
        pricing: pricing ?? _pricing,
        slotinternval: slotinternval ?? _slotinternval,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        createdBy: createdBy ?? _createdBy,
        groundLocation: groundLocation ?? _groundLocation,
      );
  num? get id => _id;
  String? get name => _name;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  num? get phone => _phone;
  String? get profilePic => _profilePic;
  OfferPics? get offerPics => _offerPics;
  num? get pricing => _pricing;
  num? get slotinternval => _slotinternval;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get groundLocation => _groundLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['phone'] = _phone;
    map['profile_pic'] = _profilePic;
    if (_offerPics != null) {
      map['offer_pics'] = _offerPics?.toJson();
    }
    map['pricing'] = _pricing;
    map['slotinternval'] = _slotinternval;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['ground_location'] = _groundLocation;
    return map;
  }
}

class OfferPics {
  OfferPics({
    List<String>? photos,
  }) {
    _photos = photos;
  }

  OfferPics.fromJson(dynamic json) {
    _photos = json['photos'] != null ? json['photos'].cast<String>() : [];
  }
  List<String>? _photos;
  OfferPics copyWith({
    List<String>? photos,
  }) =>
      OfferPics(
        photos: photos ?? _photos,
      );
  List<String>? get photos => _photos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photos'] = _photos;
    return map;
  }
}




// class LetsPlay {
//   LetsPlay({
//       num? id, 
//       num? gameId, 
//       String? name, 
//       String? addressLine1, 
//       String? addressLine2, 
//       String? city, 
//       String? state, 
//       num? phone, 
//       String? profilePic, 
//       OfferPics? offerPics, 
//       dynamic groundPics, 
//       num? pricing, 
//       num? slotinternval, 
//       String? createdAt, 
//       String? updatedAt, 
//       String? createdBy, 
//       String? groundLocation,}){
//     _id = id;
//     _gameId = gameId;
//     _name = name;
//     _addressLine1 = addressLine1;
//     _addressLine2 = addressLine2;
//     _city = city;
//     _state = state;
//     _phone = phone;
//     _profilePic = profilePic;
//     _offerPics = offerPics;
//     _groundPics = groundPics;
//     _pricing = pricing;
//     _slotinternval = slotinternval;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _createdBy = createdBy;
//     _groundLocation = groundLocation;
// }

//   LetsPlay.fromJson(dynamic json) {
//     _id = json['id'];
//     _gameId = json['game_id'];
//     _name = json['name'];
//     _addressLine1 = json['address_line1'];
//     _addressLine2 = json['address_line2'];
//     _city = json['city'];
//     _state = json['state'];
//     _phone = json['phone'];
//     _profilePic = json['profile_pic'];
//     _offerPics = json['offer_pics'] != null ? OfferPics.fromJson(json['offer_pics']) : null;
//     _groundPics = json['ground_pics'];
//     _pricing = json['pricing'];
//     _slotinternval = json['slotinternval'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _createdBy = json['created_by'];
//     _groundLocation = json['ground_location'];
//   }
//   num? _id;
//   num? _gameId;
//   String? _name;
//   String? _addressLine1;
//   String? _addressLine2;
//   String? _city;
//   String? _state;
//   num? _phone;
//   String? _profilePic;
//   OfferPics? _offerPics;
//   dynamic _groundPics;
//   num? _pricing;
//   num? _slotinternval;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _createdBy;
//   String? _groundLocation;
// LetsPlay copyWith({  num? id,
//   num? gameId,
//   String? name,
//   String? addressLine1,
//   String? addressLine2,
//   String? city,
//   String? state,
//   num? phone,
//   String? profilePic,
//   OfferPics? offerPics,
//   dynamic groundPics,
//   num? pricing,
//   num? slotinternval,
//   String? createdAt,
//   String? updatedAt,
//   String? createdBy,
//   String? groundLocation,
// }) => LetsPlay(  id: id ?? _id,
//   gameId: gameId ?? _gameId,
//   name: name ?? _name,
//   addressLine1: addressLine1 ?? _addressLine1,
//   addressLine2: addressLine2 ?? _addressLine2,
//   city: city ?? _city,
//   state: state ?? _state,
//   phone: phone ?? _phone,
//   profilePic: profilePic ?? _profilePic,
//   offerPics: offerPics ?? _offerPics,
//   groundPics: groundPics ?? _groundPics,
//   pricing: pricing ?? _pricing,
//   slotinternval: slotinternval ?? _slotinternval,
//   createdAt: createdAt ?? _createdAt,
//   updatedAt: updatedAt ?? _updatedAt,
//   createdBy: createdBy ?? _createdBy,
//   groundLocation: groundLocation ?? _groundLocation,
// );
//   num? get id => _id;
//   num? get gameId => _gameId;
//   String? get name => _name;
//   String? get addressLine1 => _addressLine1;
//   String? get addressLine2 => _addressLine2;
//   String? get city => _city;
//   String? get state => _state;
//   num? get phone => _phone;
//   String? get profilePic => _profilePic;
//   OfferPics? get offerPics => _offerPics;
//   dynamic get groundPics => _groundPics;
//   num? get pricing => _pricing;
//   num? get slotinternval => _slotinternval;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   String? get createdBy => _createdBy;
//   String? get groundLocation => _groundLocation;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['game_id'] = _gameId;
//     map['name'] = _name;
//     map['address_line1'] = _addressLine1;
//     map['address_line2'] = _addressLine2;
//     map['city'] = _city;
//     map['state'] = _state;
//     map['phone'] = _phone;
//     map['profile_pic'] = _profilePic;
//     if (_offerPics != null) {
//       map['offer_pics'] = _offerPics?.toJson();
//     }
//     map['ground_pics'] = _groundPics;
//     map['pricing'] = _pricing;
//     map['slotinternval'] = _slotinternval;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     map['created_by'] = _createdBy;
//     map['ground_location'] = _groundLocation;
//     return map;
//   }

// }

// class OfferPics {
//   OfferPics({
//       List<String>? photos,}){
//     _photos = photos;
// }

//   OfferPics.fromJson(dynamic json) {
//     _photos = json['photos'] != null ? json['photos'].cast<String>() : [];
//   }
//   List<String>? _photos;
// OfferPics copyWith({  List<String>? photos,
// }) => OfferPics(  photos: photos ?? _photos,
// );
//   List<String>? get photos => _photos;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['photos'] = _photos;
//     return map;
//   }

// }