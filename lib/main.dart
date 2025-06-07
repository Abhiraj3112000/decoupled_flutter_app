// lib/main.dart
import 'package:flutter/material.dart';
import 'presentation/post_screen.dart';
import 'locator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(home: PostScreen()),
    ),
  );
}