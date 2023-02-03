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

  StreamSubscription startListening(Function() observer,
      {bool isFilteredForMine = false}) {
    Query query = _ref.orderBy(kMovieQuote_lastTouched, descending: true);
    if (isFilteredForMine) {
      query = query.where(kMovieQuote_authorUid,
          isEqualTo: AuthManager.instance.uid);
    }
    return _ref.snapshots().listen((QuerySnapshot) {
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

//Firebase UI Firestore stuff

//All quotes
  Query<MovieQuote> get allMovieQuotesQuery => _ref
      .orderBy(kMovieQuote_lastTouched, descending: true)
      .withConverter<MovieQuote>(
        fromFirestore: (snapshot, _) => MovieQuote.from(snapshot),
        toFirestore: (mq, _) => mq.toMap(),
      );

//Mine quotes
  Query<MovieQuote> get mineOnlyMovieQuotesQuery => allMovieQuotesQuery
      .where(kMovieQuote_authorUid, isEqualTo: AuthManager.instance.uid);
}
