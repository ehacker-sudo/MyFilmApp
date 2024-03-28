import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/user.dart';

class Review {
  final String author;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;
  final User authorDetails;

  Review({
    String? author,
    String? content,
    String? createdAt,
    String? id,
    String? updatedAt,
    String? url,
    User? authorDetails,
  })  : author = author ?? "",
        content = content ?? "",
        createdAt = createdAt ?? "",
        id = id ?? "",
        updatedAt = updatedAt ?? "",
        url = url ?? "",
        authorDetails = authorDetails ?? User();

  factory Review.fromJson(Map<String, dynamic> json) {
    User authorDetails = User();
    if (json['author_details'] != null) {
      authorDetails = User.fromJson(json['author_details']);
    }

    return Review(
      author: json["author"] ?? "",
      content: json["content"] ?? "",
      createdAt: json["createdAt"] ?? "",
      id: json["id"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      url: json["url"] ?? "",
      authorDetails: authorDetails,
    );
  }
}

class ListReview {
  final List<Review> items;

  ListReview(
    List<Review>? items,
  ) : items = items ?? [];

  factory ListReview.fromJson(
    List<Map<String, dynamic>> list,
  ) {
    final items = [for (final item in list) Review.fromJson(item)];

    return ListReview(
      items,
    );
  }
}
