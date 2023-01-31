import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_quotes/managers/auth_manager.dart';

import '../models/movie_quote.dart';

class MovieQuoteCollectionManager {
  List<MovieQuote> latestMovieQuotes = [];
  final CollectionReference _ref;

  static final MovieQuoteCollectionManager instance =
      MovieQuoteCollectionManager._privateConstructor();

  MovieQuoteCollectionManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kMovieQuoteCollectionPath);

  StreamSubscription startListening(Function() observer) {
    return _ref
        .orderBy(kMovieQuote_lastTouched, descending: true)
        .snapshots()
        .listen((QuerySnapshot) {
      print(QuerySnapshot.docs);
      latestMovieQuotes =
          QuerySnapshot.docs.map((doc) => MovieQuote.from(doc)).toList();
      observer();
      print(latestMovieQuotes);
    });
  }

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  Future<void> add({
    required String quote,
    required String movie,
  }) {
    return _ref
        .add({
          kMovieQuote_authorUid: AuthManager.instance.uid,
          kMovieQuote_quote: quote, // John Doe
          kMovieQuote_movie: movie, // Stokes and Sons
          kMovieQuote_lastTouched: Timestamp.now(), // 42
        })
        .then((DocumentReference docRef) =>
            print("Movie Quote added with id ${docRef.id}"))
        .catchError((error) => print("Failed to add Movie Quote: $error"));
  }
}
