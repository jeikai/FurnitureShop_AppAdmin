import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/servers/review_api_server.dart';

class ReviewRepository {
  ReviewAPIServer reviewAPIServer = ReviewAPIServer();

  Future<void> addReview(Review review) async {
    Map<String, dynamic> data = review.toMap();
    await reviewAPIServer.add(data);
  }

  Future<List<Review>> getReviews() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('reviews');
    List<Review> reviews = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Review a = Review.fromMap(data, id: doc.id);
          if (a.numberStart != null) reviews.add(a);
          return a;
        }
        return Review.template();
      }).toList();
    });
    return reviews;
  }

  Future<List<Review>> getReviewsByProduct(Product product) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('reviews');
    List<Review> reviews = [];
    await collection.where('productID', isEqualTo: product.id).get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Review a = Review.fromMap(data, id: doc.id);
          if (a.numberStart != null) reviews.add(a);
          return a;
        }
        return Review.template();
      }).toList();
    });
    return reviews;
  }

  Future<void> updateReview(Review review) async {
    if (review.id != null) await ReviewAPIServer().updateReview(review.toMap(), review.id!, review.product);
  }
}
