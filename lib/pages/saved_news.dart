import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weathernews_app/consts/img_placeholder.dart';
import 'package:weathernews_app/cubit/saved_news_cubit.dart';
import 'package:weathernews_app/models/saved_news_model.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: BlocBuilder<SavedNewsCubit, SavedNewsState>(
        builder: (context, state) {
          if (state is SavedNewsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SavedNewsStateLoaded) {
            final List<SavedNewsModel> news = state.news;
            if (news.isNotEmpty) {
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final article = news[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Check if urlToImage is not empty or null
                        article.urlToImage.isNotEmpty
                            ? Image.network(
                                article.urlToImage,
                                errorBuilder: (context, error, stackTrace) {
                                  // Provide a fallback image if the network image fails
                                  return Image.network(placeholder);
                                },
                              )
                            : Image.network(
                                placeholder), // Fallback image if urlToImage is empty or null
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
                              Text(article.description),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      await _launchUrl(Uri.parse(article
                                          .url)); // Pass the Uri of the article
                                    },
                                    child: const Text('Open'),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context
                                          .read<SavedNewsCubit>()
                                          .deleteNews(article.id!);
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
            } else {
              return const Center(child: Text('No saved news'));
            }
          } else if (state is SavedNewsStateError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No saved news'));
          }
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
