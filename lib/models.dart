class DbUser {
  final String city; // niepolomice
  final bool isAdmin;

  DbUser({required this.city, required this.isAdmin});

  factory DbUser.fromFirestore(Map<String, dynamic> json) {
    try {
      bool isAdmin = json['isAdmin'];
      return DbUser(
        city: json['city'],
        isAdmin: isAdmin,
      );
    } catch (_) {
      return DbUser(
        city: json['city'],
        isAdmin: false,
      );
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'city': city,
    };
  }
}

class DbPost {
  final String id;
  final String title; // niepolomice
  final String uidOfImage; // from firebase storage
  final String uidOfUser; // from firebase auth
  final String description; // description of post
  final String city; // niepolomice
  final List<String> upvotes; // uid of users
  final List<String> downvotes; // uid of users
  final double latitude;
  final double longitude;

  DbPost({
    required this.id,
    required this.title,
    required this.uidOfImage,
    required this.uidOfUser,
    required this.description,
    required this.city,
    required this.upvotes,
    required this.downvotes,
    required this.latitude,
    required this.longitude,
  });

  // write constructor for class from firebase
  factory DbPost.fromFirestore(Map<String, dynamic> map, String id) {
    var arrayU = map['upvotes'];
    var arrayD = map['downvotes'];
    var listU = arrayU.cast<String>();
    var listD = arrayD.cast<String>();

    try {
      return DbPost(
        id: id,
        title: map['title'],
        uidOfImage: map['uidOfImage'],
        uidOfUser: map['uidOfUser'],
        description: map['description'],
        city: map['city'],
        upvotes: listU,
        downvotes: listD,
        latitude: map['latitude'],
        longitude: map['longitude'],
      );
    } catch (e) {
      print(e);
      return DbPost(
        id: id,
        title: "error",
        uidOfImage:
            "https://freesvg.org/img/molumen_red_square_error_warning_icon.png",
        uidOfUser: "error",
        description: "error",
        city: "error",
        upvotes: [],
        downvotes: [],
        latitude: 0,
        longitude: 0,
      );
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uidOfImage': uidOfImage,
      'uidOfUser': uidOfUser,
      'description': description,
      'city': city,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
