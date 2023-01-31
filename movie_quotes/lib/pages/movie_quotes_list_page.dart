import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_quotes/components/list_page_side_drawer.dart';
import 'package:movie_quotes/components/movie_quote_row_component.dart';
import 'package:movie_quotes/managers/auth_manager.dart';
import 'package:movie_quotes/managers/movie_quotes_collection_manager.dart';
import 'package:movie_quotes/models/movie_quote.dart';
import 'package:movie_quotes/pages/movie_quote_detail_page.dart';

import 'login_front_page.dart';

class MovieQuotesListPage extends StatefulWidget {
  const MovieQuotesListPage({super.key});

  @override
  State<MovieQuotesListPage> createState() => _MovieQuotesListPageState();
}

class _MovieQuotesListPageState extends State<MovieQuotesListPage> {
  final quotes = <MovieQuote>[]; // Later we will remove this and use Firestore
  final quoteTextController = TextEditingController();
  final movieTextController = TextEditingController();

  StreamSubscription? movieQuotesSubscription;

  UniqueKey? _loginObserverKey;
  UniqueKey? _logoutObserverKey;

  @override
  void initState() {
    super.initState();

    movieQuotesSubscription =
        MovieQuoteCollectionManager.instance.startListening(() {
      setState(() {});
    });

    _loginObserverKey = AuthManager.instance.addLoginObserver(() {
      setState(() {});
    });

    _logoutObserverKey = AuthManager.instance.addLogoutObserver(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    quoteTextController.dispose();
    movieTextController.dispose();
    MovieQuoteCollectionManager.instance.stopListening(movieQuotesSubscription);
    AuthManager.instance.removeObserver(_loginObserverKey);
    AuthManager.instance.removeObserver(_logoutObserverKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MovieQuoteRow> movieRows =
        MovieQuoteCollectionManager.instance.latestMovieQuotes
            .map((mq) => MovieQuoteRow(
                  movieQuote: mq,
                  onTap: () async {
                    print(
                        "You clicked on the movie quote ${mq.quote} - ${mq.movie}");
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MovieQuoteDetailPage(
                              mq.documentId!); // In Firebase use a documentId
                        },
                      ),
                    );
                    setState(() {});
                  },
                ))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
        actions: AuthManager.instance.isSignedIn
            ? null
            : [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginFrontPage();
                      },
                    ));
                  },
                  tooltip: "Log in",
                  icon: const Icon(Icons.login),
                ),
              ],
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: movieRows,
      ),
      drawer: AuthManager.instance.isSignedIn ? ListPageSideDrawer() : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (AuthManager.instance.isSignedIn) {
            showCreateQuoteDialog(context);
          } else {
            showMustLogInDialog(context);
          }
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
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
                  MovieQuoteCollectionManager.instance.add(
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

  Future<void> showMustLogInDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Required"),
          content: const Text(
              "You must be signed in to post.  Would you like to sign in now?"),
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
              child: const Text("Go sign in"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginFrontPage();
                  },
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
