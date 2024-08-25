class Booking {
  int? id;
  String? createdAt;
  int? vendorId;
  String? startDateTime;
  String? endDateTime;
  String? notes;
  String? updatedAt;
  String? bookingDate;
  bool? isBooked = false;

  Booking(
      {this.id,
        this.createdAt,
        this.vendorId,
        this.startDateTime,
        this.endDateTime,
        this.notes,
        this.updatedAt,
        this.bookingDate,
        // this.isBooked,
       });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    vendorId = json['vendor_id'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    notes = json['notes'];
    updatedAt = json['updated_at'];
    bookingDate = json['booking_date'];
    // isBooked= json['is_Booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['vendor_id'] = this.vendorId;
    data['start_date_time'] = this.startDateTime;
    data['end_date_time'] = this.endDateTime;
    data['notes'] = this.notes;
    data['updated_at'] = this.updatedAt;
    data['booking_date'] = this.bookingDate;
    // data['is_Booked'] = this.isBooked;
    return data;
  }
}

// new database

// class Booking {
//   int? id;
//   int? vendorId;
//   String? notes;
//   String? startDateTime;
//   String? endDateTime;
//   String? bookingDate;
//   String? createdAt;
//   String? updatedAt;
//   bool? isBooked = false;

//   Booking(
//       {this.id,
//       this.vendorId,
//       this.notes,
//       this.startDateTime,
//       this.endDateTime,
//       this.bookingDate,
//       this.createdAt,
//       this.updatedAt});

//   Booking.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     notes = json['notes'];
//     startDateTime = json['start_date_time'];
//     endDateTime = json['end_date_time'];
//     bookingDate = json['booking_date'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_id'] = this.vendorId;
//     data['notes'] = this.notes;
//     data['start_date_time'] = this.startDateTime;
//     data['end_date_time'] = this.endDateTime;
//     data['booking_date'] = this.bookingDate;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
