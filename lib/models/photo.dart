class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Photo copyWith({
    required int albumId,
    required int id,
    required String title,
    required String url,
    required String thumbnailUrl,
  }) {
    return Photo(
      albumId: albumId,
      id: id,
      title: title,
      url: url,
      thumbnailUrl: thumbnailUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId:
          json['albumId'] is int ? json['albumId'] : int.parse(json['albumId']),
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
