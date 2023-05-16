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

  factory ImageInformation.fromJson(Map<String, dynamic> json) {
    return ImageInformation(
        id: json['id'] ?? '',
        author: json['author'] ?? '',
        width: json['width']?.toInt() ?? 0,
        height: json['height']?.toInt() ?? 0,
        url: json['url'] ?? '',
        downloadUrl: json['download_url'] ?? '');
  }
}
