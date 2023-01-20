import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_quotes/models/movie_quote.dart';

class MovieQuoteDocumentManager {
  MovieQuote? latestMovieQuote;
  final CollectionReference _ref;

  static final MovieQuoteDocumentManager instance =
      MovieQuoteDocumentManager._privateConstructor();

  MovieQuoteDocumentManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kMovieQuoteCollectionPath);

  StreamSubscription startListening(String documentId, Function() observer) {
    return _ref
        .doc(documentId)
        .snapshots()
        .listen((DocumentSnapshot docSnapshot) {
      latestMovieQuote = MovieQuote.from(docSnapshot);
      observer();
    });
  }

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  Future<void> update({
    required String quote,
    required String movie,
  }) {
    return _ref.doc(latestMovieQuote!.documentId).update({
      kMovieQuote_quote: quote,
      kMovieQuote_movie: movie,
      kMovieQuote_lastTouched: Timestamp.now(),
    }).catchError((error) => print("Failed to add movie quote: $error"));
  }

  void deleteLatestMovieQuote() {
    _ref.doc(latestMovieQuote!.documentId).delete();
  }
}
