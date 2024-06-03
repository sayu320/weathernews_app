import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weathernews_app/consts/api_keys.dart';
import 'package:weathernews_app/consts/img_placeholder.dart';
import 'package:weathernews_app/cubit/saved_news_cubit.dart';
import 'package:weathernews_app/cubit/settings/settings_cubit.dart';
import 'package:weathernews_app/models/news_model.dart';
import 'package:weathernews_app/models/saved_news_model.dart';
import 'package:weathernews_app/services/news_service.dart';

class FavouriteNewsScreen extends StatefulWidget {
  const FavouriteNewsScreen({super.key});

  @override
  _FavouriteNewsScreenState createState() => _FavouriteNewsScreenState();
}

class _FavouriteNewsScreenState extends State<FavouriteNewsScreen> {
  final NewsService _newsService = NewsService.create();
  Future<List<NewsArticle>>? _newsArticles;
  bool _hasInternetConnection = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    context.read<SettingsCubit>().stream.listen((state) {
      if (_hasInternetConnection) {
        _fetchFavouriteNews();
      }
    });
  }

  void _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _hasInternetConnection = connectivityResult != ConnectivityResult.none;
      if (_hasInternetConnection) {
        _fetchFavouriteNews();
      } else {
        _newsArticles = Future.error('No internet connection');
      }
    });
  }

  void _fetchFavouriteNews() async {
    List<String> favouriteCategories = context.read<SettingsCubit>().favoriteCategories;
    if (favouriteCategories.isNotEmpty) {
      const formattedDate = '2024-5-15';
      setState(() {
        _newsArticles = Future.wait(favouriteCategories.map((category) {
          return _newsService
              .getNews(
            category,
            formattedDate,
            'publishedAt',
            newsApiKey,
          )
              .then((response) {
            if (response.isSuccessful) {
              final body = response.body;
              final articles = (body!['articles'] as List)
                  .map((json) => NewsArticle.fromJson(json))
                  .toList();
              return articles;
            } else {
              throw Exception('Failed to load news');
            }
          });
        })).then((results) => results.expand((x) => x).toList());
      });
    } else {
      setState(() {
        _newsArticles = Future.value([]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite News'),
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
                return const Center(child: Text('Error loading news'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No favourite news available'));
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
