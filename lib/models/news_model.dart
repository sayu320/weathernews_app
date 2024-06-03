class NewsArticle {
  final int id;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;

  NewsArticle( {
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt, 
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}