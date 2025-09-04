import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadUserProfile() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) return;

      _isLoading = true;
      notifyListeners();

      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        _userProfile = doc.data() as Map<String, dynamic>?;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
  }) async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) return;

      _isLoading = true;
      notifyListeners();

      final Map<String, dynamic> updates = {};
      
      if (displayName != null) {
        updates['displayName'] = displayName;
        await _auth.currentUser!.updateDisplayName(displayName);
      }
      
      if (bio != null) {
        updates['bio'] = bio;
      }

      if (updates.isNotEmpty) {
        updates['updatedAt'] = FieldValue.serverTimestamp();
        
        await _firestore
            .collection('users')
            .doc(userId)
            .update(updates);

        // Update local profile
        if (_userProfile != null) {
          _userProfile!.addAll(updates);
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAvatar() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) return;

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image == null) return;

      _isLoading = true;
      notifyListeners();

      // Upload image to Firebase Storage
      final String fileName = 'avatars/$userId.jpg';
      final Reference ref = _storage.ref().child(fileName);
      
      final UploadTask uploadTask = ref.putFile(File(image.path));
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update user profile with new avatar URL
      await _firestore.collection('users').doc(userId).update({
        'avatarUrl': downloadUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update Firebase Auth profile
      await _auth.currentUser!.updatePhotoURL(downloadUrl);

      // Update local profile
      if (_userProfile != null) {
        _userProfile!['avatarUrl'] = downloadUrl;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) return;

      _isLoading = true;
      notifyListeners();

      // Delete user document from Firestore
      await _firestore.collection('users').doc(userId).delete();

      // Delete user avatar from Storage if exists
      if (_userProfile?['avatarUrl'] != null) {
        try {
          final Reference ref = _storage.refFromURL(_userProfile!['avatarUrl']);
          await ref.delete();
        } catch (e) {
          // Avatar deletion failed, but continue with account deletion
        }
      }

      // Delete Firebase Auth account
      await _auth.currentUser!.delete();

      _userProfile = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
