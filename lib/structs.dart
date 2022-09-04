import 'dart:convert';

class hUser {
  String username, fname, lname, email, phone, image, id;
  List<hOrg> orgs;
  DateTime birthday;
  //final List<hEvent> events;

  hUser(this.username, this.fname, this.email, this.lname, this.phone,
      this.image, this.birthday, this.id, this.orgs);

  hUser.fromJson(Map<String, dynamic> json)
      : username = json['Username'],
        email = json['Email'],
        phone = json['PhoneNumber'],
        fname = json['FirstName'],
        lname = json['LastName'],
        image = json['ImageUrl'],
        birthday = DateTime.parse('2003-04-09'),
        id = json['ID'],
        orgs = [];
  //events = hEvent.fromJson(json['Events']);

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };
}

class hEvent {
  String name, location, desc, image, uuid, orguuid;
  DateTime date;
  String orgName, orgImage;
  //final List<hEvent> events;

  hEvent(this.name, this.date, this.location, this.desc, this.image, this.uuid,
      this.orguuid, this.orgName, this.orgImage);

  hEvent.fromJson(Map<String, dynamic> json)
      : name = json['event_name'],
        date = DateTime.parse(json['event_date']),
        location = json['event_location'],
        desc = json['event_description'],
        image = json['event_image'],
        uuid = json['uuid'],
        orguuid = json['org_uuid'],
        orgImage = json['org_image'],
        orgName = json['org_name'];
  //events = hEvent.fromJson(json['Events']);
  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };
}

class hOrg {
  String name, image, location, uuid;
  double policy;
  //final List<hEvent> events;

  hOrg(this.name, this.location, this.policy, this.image, this.uuid);

  hOrg.fromJson(Map<String, dynamic> json)
      : name = json['org_name'],
        location = json['city'],
        uuid = json['uuid'],
        image = json['org_image'],
        policy = json['policy_num'];
  //events = hEvent.fromJson(json['Events']);

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };
}

class Bearer {
  final String bearer_token;
  const Bearer({required this.bearer_token});
  factory Bearer.fromJson(Map<String, dynamic> json) {
    return Bearer(bearer_token: json['bearer_token']);
  }
}

class Res {
  final Bearer data;
  final int error_code;
  const Res({required this.data, required this.error_code});
  factory Res.fromJson(dynamic json) {
    return Res(
        data: Bearer.fromJson(json['data']), error_code: json['error_code']);
  }
}
