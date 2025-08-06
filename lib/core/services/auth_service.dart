import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/models/user.dart';

class AuthService extends ChangeNotifier {
  // Firebase Auth instance (temporarily disabled)
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Temporary local state
  User? _currentUser;
  bool _isLoading = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  // Initialize auth state (temporarily disabled)
  // Future<void> initialize() async {
  //   _auth.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       _loadUserData(user.uid);
  //     } else {
  //       _currentUser = null;
  //       notifyListeners();
  //     }
  //   });
  // }

  // Load user data from Firestore (temporarily disabled)
  // Future<void> _loadUserData(String uid) async {
  //   try {
  //     final doc = await _firestore.collection('users').doc(uid).get();
  //     if (doc.exists) {
  //       _currentUser = User.fromJson(doc.data()!);
  //     } else {
  //       // Create new user document
  //       _currentUser = User(
  //         id: uid,
  //         email: _auth.currentUser?.email ?? '',
  //         displayName: _auth.currentUser?.displayName ?? '',
  //         photoURL: _auth.currentUser?.photoURL ?? '',
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now(),
  //       );
  //       await _firestore.collection('users').doc(uid).set(_currentUser!.toJson());
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error loading user data: $e');
  //   }
  // }

  // Sign in with email and password (temporarily simplified)
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Temporary mock authentication
      if (email.isNotEmpty && password.isNotEmpty) {
        _currentUser = User(
          id: 'temp_user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: email.split('@')[0],
          photoURL: '',
          joinDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Email y contraseña son requeridos');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Create user with email and password (temporarily simplified)
  Future<bool> createUserWithEmailAndPassword(String email, String password, String displayName) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Temporary mock user creation
      if (email.isNotEmpty && password.isNotEmpty && displayName.isNotEmpty) {
        _currentUser = User(
          id: 'temp_user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: displayName,
          photoURL: '',
          joinDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Todos los campos son requeridos');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign in with Google (temporarily disabled)
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Temporary mock Google sign in
      _currentUser = User(
        id: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'user@gmail.com',
        displayName: 'Usuario Google',
        photoURL: '',
        joinDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign in with Apple (temporarily disabled)
  Future<bool> signInWithApple() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Temporary mock Apple sign in
      _currentUser = User(
        id: 'apple_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'user@icloud.com',
        displayName: 'Usuario Apple',
        photoURL: '',
        joinDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign in with Facebook (temporarily disabled)
  Future<bool> signInWithFacebook() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Temporary mock Facebook sign in
      _currentUser = User(
        id: 'facebook_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'user@facebook.com',
        displayName: 'Usuario Facebook',
        photoURL: '',
        joinDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign out (temporarily simplified)
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Clear local state
      _currentUser = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Reset password (temporarily simplified)
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Temporary mock password reset
      if (email.isEmpty) {
        throw Exception('Email es requerido');
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Send password reset email (alias for resetPassword)
  Future<void> sendPasswordResetEmail(String email) async {
    return resetPassword(email);
  }

  // Update user profile (temporarily simplified)
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    if (_currentUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(milliseconds: 500));
      
      _currentUser = _currentUser!.copyWith(
        displayName: displayName ?? _currentUser!.displayName,
        photoURL: photoURL ?? _currentUser!.photoURL,
        updatedAt: DateTime.now(),
      );
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
} 