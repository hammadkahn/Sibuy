import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Referal extends StatelessWidget {
  const Referal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6600),
        title: const Text('Referal'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/ref.png'),
          SizedBox(
            height: 10,
          ),
          //Text with bold font
          const Text(
            'SiBuy/45689',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //inkwell on container showing linked copy

                InkWell(
                  onTap: () {
                    final link = "https://www.example.com";
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Link copied to clipboard"),
                          content: Text(
                              "The link has been copied to your clipboard."),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: link));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: InkWell(
                    onTap: () async {},
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6600),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Copy Link',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6600),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Share Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
