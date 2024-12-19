import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String?> note = Get.arguments; // Accept nullable values

    return Scaffold(
      appBar: AppBar(
        title: Text(note['title'] ?? "Note Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['title'] ?? "",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              note['description'] ?? "",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
