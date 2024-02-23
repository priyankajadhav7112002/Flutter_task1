class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Post copyWith({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) {
    return Post(
      userId: userId,
      id: id,
      title: title,
      body: body,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId:
          json['userId'] is int ? json['userId'] : int.parse(json['userId']),
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      title: json['title'],
      body: json['body'],
    );
  }
}
