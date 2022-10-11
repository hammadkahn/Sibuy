import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  const Points({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Points'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/points.png', height: 200, width: 200),
            SizedBox(
              height: 20,
            ),
            //Text with bold font
            const Text(
              'You Have 1857 Points',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
