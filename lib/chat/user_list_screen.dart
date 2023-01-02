import 'package:flutter/material.dart';
import 'package:SiBuy/chat/chat_screen.dart';
import 'package:SiBuy/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import '../../constant/color_constant.dart';
import '../shared/loader.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false)
        .getAllConversation(widget.token);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: FutureBuilder<Conversation>(
          future: chatProvider,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Loader();

              default:
                if (snapshot.data == null || snapshot.data!.data!.isEmpty) {
                  return Center(
                    child: TextButton(
                      child: const Text('Start Chat with Admin'),
                      onPressed: () {
                        createConversation().whenComplete(() {
                          if (conversationId != null &&
                              conversationId!.isNotEmpty) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ChatScreen(
                                  token: widget.token,
                                  conversationId: conversationId!,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Error while contacting with admin')));
                          }
                        });
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: ((context, index) {
                      var data = snapshot.data!.data!;
                      // setState(() {
                      //   name = data[index].oppositeUser!.name;
                      // });
                      if (data[index].oppositeUser!.name == 'Admin') {
                        return ListTile(
                          tileColor: AppColors.APP_PRIMARY_COLOR,
                          onTap: () {
                            // onConnectPressed(userId!);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ChatScreen(
                                  token: widget.token,
                                  conversationId:
                                      snapshot.data!.data![index].id.toString(),
                                ),
                              ),
                            );
                          },
                          title: Text(
                            data[index].oppositeUser!.name ?? 'no name',
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: const Icon(
                            Icons.person,
                            size: 20,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return const SizedBox(
                            // child: TextButton(
                            //   child: const Text('Start Chat with Admin'),
                            //   onPressed: () {
                            //     createConversation().whenComplete(() {
                            //       if (conversationId != null ||
                            //           conversationId!.isNotEmpty) {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (ctx) => ChatScreen(
                            //               token: widget.token,
                            //               conversationId: conversationId!,
                            //             ),
                            //           ),
                            //         );
                            //       } else {
                            //         ScaffoldMessenger.of(context).showSnackBar(
                            //             const SnackBar(
                            //                 content: Text(
                            //                     'Error while contacting with admin')));
                            //       }
                            //     });
                            //   },
                            // ),
                            );
                      }
                    }),
                  );
                }
            }
          },
        ),
      ),
    );
  }

  String? conversationId;
  Future<void> createConversation() async {
    final result = await Provider.of<ChatProvider>(context, listen: false)
        .createCoversation(widget.token, 'hello');

    setState(() {
      conversationId = result;
    });
    debugPrint(conversationId);
  }
}
