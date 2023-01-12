import 'package:flutter/material.dart';
import 'package:movie_quotes/components/movie_quote_row_component.dart';
import 'package:movie_quotes/pages/movie_quote_detail_page.dart';

import '../models/movie_quote.dart';

class MovieQuoteListPage extends StatefulWidget {
  const MovieQuoteListPage({super.key});

  @override
  State<MovieQuoteListPage> createState() => _MovieQuoteListPage();
}

class _MovieQuoteListPage extends State<MovieQuoteListPage> {
  final movieTextController = TextEditingController();
  final quoteTextController = TextEditingController();
  final quotes =
      <MovieQuote>[]; // later we will remove this and use the firestore

  @override
  void initState() {
    super.initState();
    quotes.add(
      MovieQuote(quote: "I'll be back", movie: "The Terminator"),
    );

    quotes.add(
      MovieQuote(quote: "ok", movie: "movie"),
    );

    quotes.add(
      MovieQuote(quote: "third", movie: "movie"),
    );
  }

  @override
  void dispose() {
    quoteTextController.dispose();
    movieTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MovieQuoteRow> movieRows = [];
    for (MovieQuote mq in quotes) {
      movieRows.add(MovieQuoteRow(
        movieQuote: mq,
        onTap: () {
          print("You clicked on the movie quote ${mq.quote} - ${mq.movie}");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MovieQuoteDetailPage(
                    mq); // In firebase, use a document ID
              },
            ),
          );
        },
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        // children: [
        //   MovieQuoteRow(mq: quotes[0]),
        //   MovieQuoteRow(mq: quotes[1]),
        //   MovieQuoteRow(mq: quotes[2]),
        // ],
        children: movieRows,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateQuoteDialog(context);
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showCreateQuoteDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a Movie Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: quoteTextController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the quote',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: movieTextController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the movie',
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
              child: const Text('Create'),
              onPressed: () {
                setState(() {
                  quotes.add(MovieQuote(
                      quote: quoteTextController.text,
                      movie: movieTextController.text));
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
