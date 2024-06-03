import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weathernews_app/consts/api_keys.dart';
import 'package:weathernews_app/consts/img_placeholder.dart';
import 'package:weathernews_app/cubit/saved_news_cubit.dart';
import 'package:weathernews_app/models/news_model.dart';
import 'package:weathernews_app/models/saved_news_model.dart';
import '../services/news_service.dart';
import 'package:intl/intl.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  _AllNewsScreenState createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  final NewsService _newsService = NewsService.create();
  Future<List<NewsArticle>>? _newsArticles;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews() {
    const formattedDate = '2024-5-15';
    const query = 'technology';
    print('Fetching news from: $formattedDate with query: $query');

    setState(() {
      _newsArticles = _newsService
          .getNews(
        query, // Query parameter to search for articles
        formattedDate,
        'publishedAt',
        newsApiKey,
      )
          .then((response) {
        if (response.isSuccessful) {
          final body = response.body;
          print('API response body: $body'); // Debug: Print API response body
          final articles = (body!['articles'] as List)
              .map((json) => NewsArticle.fromJson(json))
              .toList();
          print('Parsed articles: $articles'); // Debug: Print parsed articles
          return articles;
        } else {
          print(
              'API request failed: ${response.error}'); // Debug: Print API request error
          throw Exception('Failed to load news');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All News'),
      ),
      body: BlocConsumer<SavedNewsCubit, SavedNewsState>(
        listener: (context, state) {
          // Optionally handle state changes
        },
        builder: (context, state) {
          return FutureBuilder<List<NewsArticle>>(
            future: _newsArticles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(
                    'Error in FutureBuilder: ${snapshot.error}'); // Debug: Print error in FutureBuilder
                return const Center(child: Text('Error loading news'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print('No news available'); // Debug: Print if no news is available
                return const Center(child: Text('No news available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data![index];
                    final Uri articleUri = Uri.parse(article.url);
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article.urlToImage.isNotEmpty)
                            Image.network(
                              article.urlToImage,
                              errorBuilder: (context, error, stackTrace) {
                                // Placeholder image in case of an error loading the image
                                return Image.network(
                                  placeholder,
                                  width: 100,
                                  height: 100,
                                );
                              },
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  DateFormat('yyyy-MM-dd - kk:mm')
                                      .format(article.publishedAt),
                                ),
                                const SizedBox(height: 8.0),
                                Text(article.description),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        _launchUrl(articleUri);
                                      },
                                      child: const Text('Open'),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: () {
                                        Share.share(article.url);
                                      },
                                    ),
                                    FutureBuilder<bool>(
                                      future: context
                                          .read<SavedNewsCubit>()
                                          .isNewsSaved(article.url),
                                      builder: (context, snapshot) {
                                        final isSaved = snapshot.data ?? false;
                                        return IconButton(
                                          icon: Icon(
                                            isSaved
                                                ? Icons.bookmark
                                                : Icons.bookmark_border,
                                          ),
                                          onPressed: () {
                                            final savedNews = SavedNewsModel(
                                              title: article.title,
                                              description: article.description,
                                              url: article.url,
                                              urlToImage: article.urlToImage,
                                              publishedAt: article.publishedAt,
                                            );
                                            if (isSaved) {
                                              context
                                                  .read<SavedNewsCubit>()
                                                  .deleteNews(article.id);
                                            } else {
                                              context
                                                  .read<SavedNewsCubit>()
                                                  .saveNews(savedNews);
                                            }
                                            // Refresh the UI
                                            context.read<SavedNewsCubit>().loadSavedNews();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _launchUrl(Uri articleUri) async {
    if (!await launchUrl(articleUri)) {
      throw Exception('Could not launch $articleUri');
    }
  }
}
