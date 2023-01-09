import 'package:flutter/material.dart';
import 'package:movie_quotes/components/movie_quote_row_component.dart';

import '../models/movie_quote.dart';

class MovieQuoteListPage extends StatefulWidget {
  const MovieQuoteListPage({super.key});

  @override
  State<MovieQuoteListPage> createState() => _MovieQuoteListPage();
}

class _MovieQuoteListPage extends State<MovieQuoteListPage> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          MovieQuoteRow(mq: quotes[0]),
          MovieQuoteRow(mq: quotes[1]),
          MovieQuoteRow(mq: quotes[2]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("You pressed the fab!");
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }
}
