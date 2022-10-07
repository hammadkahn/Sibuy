import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gigi_app/providers/chat_provider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/api_urls.dart';

class Message_write extends StatefulWidget {
  const Message_write({Key? key, this.token, this.id}) : super(key: key);
  final String? token;
  final String? id;

  @override
  State<Message_write> createState() => _Message_writeState();
}

class _Message_writeState extends State<Message_write> {
  final msgController = TextEditingController();
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  PusherChannel? myChannel;

  String? userId;
  String? channelName;
  Future<void> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId').toString();
    });
  }

  @override
  void initState() {
    getCurrentUserId().whenComplete(() {
      // onConnectPressed(userId!);
    });
    super.initState();
  }

  void onConnectPressed(String id) async {
    FocusScope.of(context).requestFocus(FocusNode());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await pusher.init(
        apiKey: '814fe1b741785e7ace5e',
        cluster: 'ap2',
        authEndpoint: '${ApiUrls.baseUrl}channelAuthorization',
        onAuthorizer: onAuthorizer,
        onEvent: onEvent,
      );
      myChannel = await pusher.subscribe(
        channelName: 'private-messages-channel.$id',
        onSubscriptionSucceeded: (channelName, data) {
          print("Subscribed to $channelName");
          print("I can now access me: ${myChannel!.me}");
          print("And here are the channel members: ${myChannel!.members}");
        },
        onMemberAdded: (member) {
          print("Member added: $member");
        },
        onMemberRemoved: (member) {
          print("Member removed: $member");
        },
        onEvent: (event) {
          print("Event received: $event");
        },
      );
      debugPrint(myChannel!.channelName);
      prefs.setString("channelName", myChannel!.channelName);
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    debugPrint('$channelName, $socketId, $options');

    var authUrl = '${ApiUrls.baseUrl}channelAuthorization';
    var result = await post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: 'socket_id=$socketId&channel_name=$channelName',
    );

    log('response : ${result.body}');

    return jsonDecode(result.body);
    // debugPrint('type :${options.runtimeType}');
    // return {
    //   "auth": "foo:bar",
    //   "channel_data": '{"user_id": 2}}',
    //   "shared_secret": "foobar"
    // };
  }

  void onEvent(PusherEvent event) {
    debugPrint(event.data);
    debugPrint(event.eventName);
    debugPrint(event.channelName);
    log("onEvent: $event");
  }

  void onTriggerEventPressed(dynamic data) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("eventName", 'messaging sending');
    // prefs.setString("data", msgController.text);
    debugPrint(myChannel!.channelName);
    pusher.trigger(PusherEvent(
      channelName: myChannel!.channelName,
      eventName: 'client-event',
      data: data,
    ));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myChannel!.channelName = prefs.getString("channelName")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: Container(
          color: const Color(0xFF444253),
          // color: Color(0xFF444253),
          height: 74,
          // decoration: BoxDecoration(
          //   border: Border(
          //     top: BorderSide(color: Colors.amber, width: 0.5),
          //   ),
          // ),
          child: Row(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(left: 4, right: 16),
              //   child: Container(
              //     height: 48,
              //     width: 45.28,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(14),
              //       color: const Color(0xFF323041),
              //     ),
              //     child: IconButton(
              //       onPressed: () {},
              //       icon: Icon(
              //         Icons.add,
              //         color: Colors.grey[300],
              //         size: 25,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: InkWell(
                  child: TextFormField(
                    controller: msgController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF323041),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      hintText: 'Aa',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    autofocus: false,
                    style: const TextStyle(
                      color: Color(0xffB0B0B0),
                    ),
                    cursorWidth: 1,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // onTriggerEventPressed(msgController.text);
                  Provider.of<ChatProvider>(context, listen: false).sendMessage(
                      widget.token!, msgController.text, widget.id!);

                  msgController.clear();
                },
                icon: Icon(
                  Icons.send,
                  //color: Colors.grey[300],
                  color: const Color(0xFFB0B0B0).withOpacity(0.8),
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
