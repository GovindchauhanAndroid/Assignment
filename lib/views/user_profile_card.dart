import 'package:flutter/material.dart';


class UserProfileCard extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String createdAt;
  final String userId;

  UserProfileCard({
    required this.name,
    required this.avatarUrl,
    required this.createdAt,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {

    DateTime creationDate = DateTime.parse(createdAt);
    // String formattedDate = DateFormat.yMMMd().add_jm().format(creationDate);

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: Image.network(
                  avatarUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {

                    return Image.asset(
                      'assets/images/placeholder.jpeg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'User ID: $userId',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Created At: ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}