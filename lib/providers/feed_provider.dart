import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/post_model.dart';

class FeedProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<PostModel> _feedPosts = [];
  List<PostModel> _popularPosts = [];
  List<PostModel> _likedPosts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PostModel> get feedPosts => _feedPosts;
  List<PostModel> get popularPosts => _popularPosts;
  List<PostModel> get likedPosts => _likedPosts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFeedPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      final QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .limit(20)
          .get();

      _feedPosts = snapshot.docs
          .map((doc) => PostModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPopularPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      final QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .orderBy('likesCount', descending: true)
          .limit(20)
          .get();

      _popularPosts = snapshot.docs
          .map((doc) => PostModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadLikedPosts() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) return;

      _isLoading = true;
      notifyListeners();

      final QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .where('likedBy', arrayContains: userId)
          .orderBy('createdAt', descending: true)
          .get();

      _likedPosts = snapshot.docs
          .map((doc) => PostModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike(String postId) async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) return;

      final DocumentReference postRef = _firestore.collection('posts').doc(postId);
      final DocumentSnapshot postDoc = await postRef.get();

      if (postDoc.exists) {
        final List<dynamic> likedBy = postDoc.get('likedBy') ?? [];
        final int currentLikes = postDoc.get('likesCount') ?? 0;

        if (likedBy.contains(userId)) {
          // Unlike
          await postRef.update({
            'likedBy': FieldValue.arrayRemove([userId]),
            'likesCount': currentLikes - 1,
          });
        } else {
          // Like
          await postRef.update({
            'likedBy': FieldValue.arrayUnion([userId]),
            'likesCount': currentLikes + 1,
          });
        }

        // Update local lists
        _updatePostInLists(postId, userId, !likedBy.contains(userId));
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void _updatePostInLists(String postId, String userId, bool isLiked) {
    for (var post in _feedPosts) {
      if (post.id == postId) {
        if (isLiked) {
          post.likedBy.add(userId);
          post.likesCount++;
        } else {
          post.likedBy.remove(userId);
          post.likesCount--;
        }
        break;
      }
    }

    for (var post in _popularPosts) {
      if (post.id == postId) {
        if (isLiked) {
          post.likedBy.add(userId);
          post.likesCount++;
        } else {
          post.likedBy.remove(userId);
          post.likesCount--;
        }
        break;
      }
    }
  }
}
