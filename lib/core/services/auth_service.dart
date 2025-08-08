import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/models/user.dart';
import 'hive_database_service.dart';

class AuthService extends ChangeNotifier {
  // Firebase Auth instance (temporarily disabled)
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Hive database service
  final HiveDatabaseService _database = HiveDatabaseService.instance;
  
  // Temporary local state
  User? _currentUser;
  bool _isLoading = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  // Constructor - load saved user from Hive
  AuthService() {
    _loadSavedUser();
  }

  // Load saved user from Hive
  Future<void> _loadSavedUser() async {
    try {
      // Get the first user from database (for demo purposes)
      // In a real app, you'd store the current user ID separately
      final users = await _database.getAllUsers();
      if (users.isNotEmpty) {
        _currentUser = users.first;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading saved user: $e');
    }
  }

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

  // Sign in with email and password (with Hive persistence)
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Check if user exists in database
      final users = await _database.getAllUsers();
      User? existingUser = users.where((user) => user.email == email).firstOrNull;
      
      if (existingUser != null) {
        // User exists, load their data
        _currentUser = existingUser;
      } else {
        // Create new user
        _currentUser = User(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: email.split('@')[0],
          photoURL: '',
          joinDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        // Save to Hive
        await _database.insertUser(_currentUser!);
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Create user with email and password (with Hive persistence)
  Future<bool> createUserWithEmailAndPassword(String email, String password, String displayName) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Check if user already exists
      final users = await _database.getAllUsers();
      final existingUser = users.where((user) => user.email == email).firstOrNull;
      
      if (existingUser != null) {
        throw Exception('El usuario ya existe con este email');
      }
      
      // Create new user
      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: displayName,
        photoURL: '',
        joinDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      // Save to Hive
      await _database.insertUser(_currentUser!);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign in with Google (with Hive persistence)
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Check if Google user exists
      final users = await _database.getAllUsers();
      User? existingUser = users.where((user) => user.email == 'user@gmail.com').firstOrNull;
      
      if (existingUser != null) {
        _currentUser = existingUser;
      } else {
        // Create new Google user
        _currentUser = User(
          id: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
          email: 'user@gmail.com',
          displayName: 'Usuario Google',
          photoURL: '',
          joinDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        // Save to Hive
        await _database.insertUser(_currentUser!);
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign in with Apple (with Hive persistence)
  Future<bool> signInWithApple() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Check if Apple user exists
      final users = await _database.getAllUsers();
      User? existingUser = users.where((user) => user.email == 'user@icloud.com').firstOrNull;
      
      if (existingUser != null) {
        _currentUser = existingUser;
      } else {
        // Create new Apple user
        _currentUser = User(
          id: 'apple_user_${DateTime.now().millisecondsSinceEpoch}',
          email: 'user@icloud.com',
          displayName: 'Usuario Apple',
          photoURL: '',
          joinDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        // Save to Hive
        await _database.insertUser(_currentUser!);
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign in with Facebook (with Hive persistence)
  Future<bool> signInWithFacebook() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));
      
      // Check if Facebook user exists
      final users = await _database.getAllUsers();
      User? existingUser = users.where((user) => user.email == 'user@facebook.com').firstOrNull;
      
      if (existingUser != null) {
        _currentUser = existingUser;
      } else {
        // Create new Facebook user
        _currentUser = User(
          id: 'facebook_user_${DateTime.now().millisecondsSinceEpoch}',
          email: 'user@facebook.com',
          displayName: 'Usuario Facebook',
          photoURL: '',
          joinDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        // Save to Hive
        await _database.insertUser(_currentUser!);
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Sign out (with Hive persistence)
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

  // Update user profile (with Hive persistence)
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
      
      // Update in Hive
      await _database.updateUser(_currentUser!);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
} 