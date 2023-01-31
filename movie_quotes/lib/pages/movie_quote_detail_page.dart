import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_quotes/managers/movie_quote_document_manager.dart';
import 'package:movie_quotes/managers/movie_quotes_collection_manager.dart';

class MovieQuoteDetailPage extends StatefulWidget {
  final String documentId;
  const MovieQuoteDetailPage(this.documentId, {super.key});

  @override
  State<MovieQuoteDetailPage> createState() => _MovieQuoteDetailPageState();
}

class _MovieQuoteDetailPageState extends State<MovieQuoteDetailPage> {
  final quoteTextController = TextEditingController();
  final movieTextController = TextEditingController();

  StreamSubscription? movieQuoteSubscription;

  @override
  void initState() {
    super.initState();

    movieQuoteSubscription = MovieQuoteDocumentManager.instance.startListening(
      widget.documentId,
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    quoteTextController.dispose();
    movieTextController.dispose();
    MovieQuoteDocumentManager.instance.stopListening(movieQuoteSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
        actions: [
          Visibility(
            visible:
                MovieQuoteDocumentManager.instance.latestMovieQuote != null,
            child: IconButton(
              onPressed: () {
                showEditQuoteDialog(context);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          Visibility(
            visible:
                MovieQuoteDocumentManager.instance.latestMovieQuote != null,
            child: IconButton(
              onPressed: () {
                final justDeletedQuote =
                    MovieQuoteDocumentManager.instance.latestMovieQuote!.quote;
                final justDeletedMovie =
                    MovieQuoteDocumentManager.instance.latestMovieQuote!.movie;

                MovieQuoteDocumentManager.instance.deleteLatestMovieQuote();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Quote Deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        MovieQuoteCollectionManager.instance.add(
                          quote: justDeletedQuote,
                          movie: justDeletedMovie,
                        );
                      },
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
            ),
          ),
          const SizedBox(
            width: 40.0,
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LabelledTextDisplay(
              title: "Quote:",
              content:
                  MovieQuoteDocumentManager.instance.latestMovieQuote?.quote ??
                      "",
              iconData: Icons.format_quote_outlined,
            ),
            LabelledTextDisplay(
              title: "Movie:",
              content:
                  MovieQuoteDocumentManager.instance.latestMovieQuote?.movie ??
                      "",
              iconData: Icons.movie_filter_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showEditQuoteDialog(BuildContext context) {
    quoteTextController.text =
        MovieQuoteDocumentManager.instance.latestMovieQuote?.quote ?? "";
    movieTextController.text =
        MovieQuoteDocumentManager.instance.latestMovieQuote?.movie ?? "";

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit this Movie Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
                child: TextFormField(
                  controller: quoteTextController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Quote:',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
                child: TextFormField(
                  controller: movieTextController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Movie:',
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  MovieQuoteDocumentManager.instance.update(
                    quote: quoteTextController.text,
                    movie: movieTextController.text,
                  );
                  quoteTextController.text = "";
                  movieTextController.text = "";
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class LabelledTextDisplay extends StatelessWidget {
  final String title;
  final String content;
  final IconData iconData;

  const LabelledTextDisplay({
    super.key,
    required this.title,
    required this.content,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Caveat"),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(iconData),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 18.0,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
