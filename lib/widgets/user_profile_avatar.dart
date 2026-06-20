import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class UserProfileAvatar extends StatelessWidget {
  final String userId;
  final double radius;

  const UserProfileAvatar({
    super.key,
    required this.userId,
    this.radius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, size: radius * 1.2, color: Colors.white54),
          );
        }
        
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final profileImage = data['profileImage'] as String?;
          
          if (profileImage != null && profileImage.isNotEmpty) {
            ImageProvider imageProvider;
            if (profileImage.startsWith('data:image')) {
              imageProvider = MemoryImage(base64Decode(profileImage.split(',').last));
            } else {
              imageProvider = AssetImage(profileImage);
            }
            return CircleAvatar(
              radius: radius,
              backgroundColor: Colors.indigo.shade900,
              backgroundImage: imageProvider,
            );
          }
        }

        return CircleAvatar(
          radius: radius,
          backgroundColor: Colors.purple,
          child: Icon(Icons.person, size: radius * 1.2, color: Colors.white),
        );
      },
    );
  }
}
