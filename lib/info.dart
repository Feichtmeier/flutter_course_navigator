import 'dart:convert';

class ImageInformation {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;
  ImageInformation({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  ImageInformation copyWith({
    String? id,
    String? author,
    int? width,
    int? height,
    String? url,
    String? downloadUrl,
  }) {
    return ImageInformation(
      id: id ?? this.id,
      author: author ?? this.author,
      width: width ?? this.width,
      height: height ?? this.height,
      url: url ?? this.url,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'author': author});
    result.addAll({'width': width});
    result.addAll({'height': height});
    result.addAll({'url': url});
    result.addAll({'download_url': downloadUrl});

    return result;
  }

  factory ImageInformation.fromMap(Map<String, dynamic> map) {
    return ImageInformation(
      id: map['id'] ?? '',
      author: map['author'] ?? '',
      width: map['width']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      url: map['url'] ?? '',
      downloadUrl: map['download_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageInformation.fromJson(String source) =>
      ImageInformation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Info(id: $id, author: $author, width: $width, height: $height, url: $url, download_url: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageInformation &&
        other.id == id &&
        other.author == author &&
        other.width == width &&
        other.height == height &&
        other.url == url &&
        other.downloadUrl == downloadUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        width.hashCode ^
        height.hashCode ^
        url.hashCode ^
        downloadUrl.hashCode;
  }
}
