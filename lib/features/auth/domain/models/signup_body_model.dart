class SignUpBodyModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? code;
  String? username;
  String? whatsappNo;
  String? whatsappNo1;
  String? phone1;
  String? landmark;
  String? area;
  String? taluka;
  String? district;
  String? city;
  String? state;
  String? pincode;
  String? dob;
  String? opensAt;
  String? closesAt;
  String? address;
  String? latitude;
  String? longitude;
  String? route;
  String? subroute;
  String? zoneId;
  String? gstNo;
  String? panNo;
  String? usertype;
  List<int>? category; // assuming categories as list of IDs
  List<int>? subCategory;

  // File fields (image, pan_card, udyam_card)
  dynamic image;
  dynamic panCard;
  dynamic udyamCard;

  SignUpBodyModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.code,
    this.username,
    this.whatsappNo,
    this.whatsappNo1,
    this.phone1,
    this.landmark,
    this.area,
    this.taluka,
    this.district,
    this.city,
    this.state,
    this.pincode,
    this.dob,
    this.opensAt,
    this.closesAt,
    this.address,
    this.latitude,
    this.longitude,
    this.route,
    this.subroute,
    this.zoneId,
    this.gstNo,
    this.panNo,
    this.usertype,
    this.category,
    this.subCategory,
    this.image,
    this.panCard,
    this.udyamCard,
  });

  SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    code = json['code'];
    username = json['username'];
    whatsappNo = json['whatsapp_no'];
    whatsappNo1 = json['whatsapp_no1'];
    phone1 = json['phone1'];
    landmark = json['landmark'];
    area = json['area'];
    taluka = json['taluka'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    dob = json['dob'];
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    route = json['route'];
    subroute = json['subroute'];
    zoneId = json['zone_id'];
    gstNo = json['gst_no'];
    panNo = json['pan_no'];
    usertype = json['usertype'];
    category =
        json['category'] != null ? List<int>.from(json['category']) : null;
    subCategory = json['sub_category'] != null
        ? List<int>.from(json['sub_category'])
        : null;
    image = json['image'];
    panCard = json['pan_card'];
    udyamCard = json['udyam_card'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name ?? '';
    data['email'] = email ?? '';
    data['phone'] = phone ?? '';
    data['password'] = password ?? '';
    data['code'] = code ?? '';
    data['username'] = username ?? '';
    data['whatsapp_no'] = whatsappNo ?? '';
    data['whatsapp_no1'] = whatsappNo1 ?? '';
    data['phone1'] = phone1 ?? '';
    data['landmark'] = landmark ?? '';
    data['area'] = area ?? '';
    data['taluka'] = taluka ?? '';
    data['district'] = district ?? '';
    data['city'] = city ?? '';
    data['state'] = state ?? '';
    data['pincode'] = pincode ?? '';
    data['dob'] = dob ?? '';
    data['opens_at'] = opensAt ?? '';
    data['closes_at'] = closesAt ?? '';
    data['address'] = address ?? '';
    data['latitude'] = latitude ?? '';
    data['longitude'] = longitude ?? '';
    data['route'] = route ?? '';
    data['subroute'] = subroute ?? '';
    data['zone_id'] = zoneId ?? '';
    data['gst_no'] = gstNo ?? '';
    data['pan_no'] = panNo ?? '';
    data['usertype'] = usertype ?? '';

    // Flatten array fields
    if (category != null) {
      for (var cat in category!) {
        data['category[]'] = cat.toString();
      }
    }

    if (subCategory != null) {
      for (var sub in subCategory!) {
        data['sub_category[]'] = sub.toString();
      }
    }

    return data;
  }

  // Map<String, String> toJson() {
  //   final Map<String, String> data = <String, String>{};
  //   data['name'] = "John Doe" ?? '';
  //   data['email'] = "johnhb@example.com" ?? '';
  //   data['phone'] = "9876543rtxc210" ?? '';
  //   data['password'] = "Abcd@1234" ?? '';
  //   data['code'] = "JD001" ?? '';
  //   data['username'] = "johnny" ?? '';
  //   data['whatsapp_no'] = "9876543210" ?? '';
  //   data['whatsapp_no1'] = "9876543211" ?? '';
  //   data['phone1'] = "9876543212" ?? '';
  //   data['landmark'] = "Near Main Road" ?? '';
  //   data['area'] = "Downtown" ?? '';
  //   data['taluka'] = "TalukaX" ?? '';
  //   data['district'] = "DistrictY" ?? '';
  //   data['city'] = "Mumbai" ?? '';
  //   data['state'] = "Maharashtra" ?? '';
  //   data['pincode'] = "400001" ?? '';
  //   data['dob'] = "1990-01-01" ?? '';
  //   data['opens_at'] = "09:00" ?? '';
  //   data['closes_at'] = "21:00" ?? '';
  //   data['address'] = "123 Main Street" ?? '';
  //   data['latitude'] = "19.0760" ?? '';
  //   data['longitude'] = "72.8777" ?? '';
  //   data['route'] = "Route A" ?? '';
  //   data['subroute'] = "Subroute 1" ?? '';
  //   data['zone_id'] = "2" ?? '';
  //   data['gst_no'] = "27ABCDE1234F1Z5" ?? '';
  //   data['pan_no'] = "ABCDE1234F" ?? '';
  //   data['usertype'] = "Superstockiest" ?? '';

  //   // Flatten array fields
  //   if (category != null) {
  //     for (var cat in category!) {
  //       data['category[]'] = cat.toString();
  //     }
  //   }

  //   if (subCategory != null) {
  //     for (var sub in subCategory!) {
  //       data['sub_category[]'] = sub.toString();
  //     }
  //   }

  //   return data;
  // }
}
// class SignUpBodyModel {
//   // Existing fields
//   String? fName;
//   String? lName;
//   String? phone;
//   String? email;
//   String? password;
//   String? refCode;
//   String? deviceToken;
//   int? guestId;
//   String? name;

//   // New fields for shop & owner details
//   String? uniqueCode;
//   String? firmName;
//   String? address;
//   String? landmark;
//   String? areaPeth;
//   String? taluka;
//   String? district;
//   String? city;
//   String? state;
//   String? pincode;
//   String? route;
//   String? subroute;
//   String? latitude;
//   String? longitude;
//   String? zone;
//   String? holiday;
//   String? firstName;
//   String? lastName;
//   String? dob;
//   String? phone1;
//   String? whatsapp1;
//   String? panCardNo;
//   String? gstNo;

//   // Image as base64 (optional – depends on backend)
//   String? profileImage;
//   String? panImage;
//   String? shopImage;

//   SignUpBodyModel({
//     this.fName,
//     this.lName,
//     this.phone,
//     this.email = '',
//     this.password,
//     this.refCode = '',
//     this.deviceToken,
//     this.guestId,
//     this.name,

//     // New
//     this.uniqueCode,
//     this.firmName,
//     this.address,
//     this.landmark,
//     this.areaPeth,
//     this.taluka,
//     this.district,
//     this.city,
//     this.state,
//     this.pincode,
//     this.route,
//     this.subroute,
//     this.latitude,
//     this.longitude,
//     this.zone,
//     this.holiday,
//     this.firstName,
//     this.lastName,
//     this.dob,
//     this.phone1,
//     this.whatsapp1,
//     this.panCardNo,
//     this.gstNo,
//     this.profileImage,
//     this.panImage,
//     this.shopImage,
//   });

//   SignUpBodyModel.fromJson(Map<String, dynamic> json) {
//     fName = json['f_name'];
//     lName = json['l_name'];
//     phone = json['phone'];
//     email = json['email'];
//     password = json['password'];
//     refCode = json['ref_code'];
//     deviceToken = json['cm_firebase_token'];
//     guestId = json['guest_id'];
//     name = json['name'];

//     // New
//     uniqueCode = json['unique_code'];
//     firmName = json['firm_name'];
//     address = json['address'];
//     landmark = json['landmark'];
//     areaPeth = json['area_peth'];
//     taluka = json['taluka'];
//     district = json['district'];
//     city = json['city'];
//     state = json['state'];
//     pincode = json['pincode'];
//     route = json['route'];
//     subroute = json['subroute'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     zone = json['zone'];
//     holiday = json['holiday'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     dob = json['dob'];
//     phone1 = json['phone1'];
//     whatsapp1 = json['whatsapp1'];
//     panCardNo = json['pan_card_no'];
//     gstNo = json['gst_no'];
//     profileImage = json['profile_image'];
//     panImage = json['pan_image'];
//     shopImage = json['shop_image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['f_name'] = fName;
//     data['l_name'] = lName;
//     data['phone'] = phone;
//     data['email'] = email;
//     data['password'] = password;
//     data['ref_code'] = refCode;
//     data['cm_firebase_token'] = deviceToken;
//     data['guest_id'] = guestId;
//     data['name'] = name;

//     // New
//     data['unique_code'] = uniqueCode;
//     data['firm_name'] = firmName;
//     data['address'] = address;
//     data['landmark'] = landmark;
//     data['area_peth'] = areaPeth;
//     data['taluka'] = taluka;
//     data['district'] = district;
//     data['city'] = city;
//     data['state'] = state;
//     data['pincode'] = pincode;
//     data['route'] = route;
//     data['subroute'] = subroute;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['zone'] = zone;
//     data['holiday'] = holiday;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['dob'] = dob;
//     data['phone1'] = phone1;
//     data['whatsapp1'] = whatsapp1;
//     data['pan_card_no'] = panCardNo;
//     data['gst_no'] = gstNo;
//     data['profile_image'] = profileImage;
//     data['pan_image'] = panImage;
//     data['shop_image'] = shopImage;
//     return data;
//   }
// }

// class SignUpBodyModel {
//   String? fName;
//   String? lName;
//   String? phone;
//   String? email;
//   String? password;
//   String? refCode;
//   String? deviceToken;
//   int? guestId;
//   String? name;

//   SignUpBodyModel({
//     this.fName,
//     this.lName,
//     this.phone,
//     this.email = '',
//     this.password,
//     this.refCode = '',
//     this.deviceToken,
//     this.guestId,
//     this.name,
//   });

//   SignUpBodyModel.fromJson(Map<String, dynamic> json) {
//     fName = json['f_name'];
//     lName = json['l_name'];
//     phone = json['phone'];
//     email = json['email'];
//     password = json['password'];
//     refCode = json['ref_code'];
//     deviceToken = json['cm_firebase_token'];
//     guestId = json['guest_id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['f_name'] = fName;
//     data['l_name'] = lName;
//     data['phone'] = phone;
//     data['email'] = email;
//     data['password'] = password;
//     data['ref_code'] = refCode;
//     data['cm_firebase_token'] = deviceToken;
//     data['guest_id'] = guestId;
//     data['name'] = name;
//     return data;
//   }
// }
