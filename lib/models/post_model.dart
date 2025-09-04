import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<String> ingredients;
  final String? recipe;
  final DateTime createdAt;
  final List<String> likedBy;
  int likesCount;
  final List<String> tags;

  PostModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.ingredients,
    this.recipe,
    required this.createdAt,
    required this.likedBy,
    required this.likesCount,
    required this.tags,
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return PostModel(
      id: doc.id,
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorAvatar: data['authorAvatar'],
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      ingredients: List<String>.from(data['ingredients'] ?? []),
      recipe: data['recipe'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likedBy: List<String>.from(data['likedBy'] ?? []),
      likesCount: data['likesCount'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'title': title,
      'description': description,
      'imageUrls': imageUrls,
      'ingredients': ingredients,
      'recipe': recipe,
      'createdAt': Timestamp.fromDate(createdAt),
      'likedBy': likedBy,
      'likesCount': likesCount,
      'tags': tags,
    };
  }

  bool isLikedBy(String userId) {
    return likedBy.contains(userId);
  }
}
