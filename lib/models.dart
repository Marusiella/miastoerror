class DbUser {
  final String city; // niepolomice

  DbUser({required this.city});

  factory DbUser.fromFirestore(Map<String, dynamic> json) {
    return DbUser(
      city: json['city'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'city': city,
    };
  }
}

class DbPost {
  final String uidOfImage; // from firebase storage
  final String uidOfUser; // from firebase auth
  final String description; // description of post
  final String city; // niepolomice
  final List<String> upvotes; // uid of users
  final List<String> downvotes; // uid of users

  DbPost({
    required this.uidOfImage,
    required this.uidOfUser,
    required this.description,
    required this.city,
    required this.upvotes,
    required this.downvotes,
  });
  // write constructor for class from firebase
  factory DbPost.fromFirestore(Map<String, dynamic> map) {
    return DbPost(
      uidOfImage: map['uidOfImage'],
      uidOfUser: map['uidOfUser'],
      description: map['description'],
      city: map['city'],
      upvotes: map['upvotes'],
      downvotes: map['downvotes'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uidOfImage': uidOfImage,
      'uidOfUser': uidOfUser,
      'description': description,
      'city': city,
      'upvotes': upvotes,
      'downvotes': downvotes,
    };
  }
}
