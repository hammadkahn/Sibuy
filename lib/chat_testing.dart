import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:http/http.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ChatTestingScreen extends StatefulWidget {
  const ChatTestingScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ChatTestingScreen> createState() => _ChatTestingScreenState();
}

class _ChatTestingScreenState extends State<ChatTestingScreen> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  String _log = 'output:\n';
  final _apiKey = TextEditingController();
  final _cluster = TextEditingController();
  final _channelName = TextEditingController();
  final _eventName = TextEditingController();
  final _channelFormKey = GlobalKey<FormState>();
  final _eventFormKey = GlobalKey<FormState>();
  final _listViewController = ScrollController();
  final _data = TextEditingController();
  PusherChannel? myChannel;

  void log(String text) {
    setState(() {
      _log += "$text\n";
      Timer(
          const Duration(milliseconds: 100),
          () => _listViewController
              .jumpTo(_listViewController.position.maxScrollExtent));
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onConnectPressed() async {
    if (!_channelFormKey.currentState!.validate()) {
      return;
    }
    // Remove keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("apiKey", _apiKey.text);
    prefs.setString("cluster", _cluster.text);
    prefs.setString("channelName", _channelName.text);

    try {
      await pusher.init(
        apiKey: '814fe1b741785e7ace5e',
        cluster: 'ap2',
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        authEndpoint:
            "https://gigiapi.zanforthstaging.com/api/channelAuthorization",
        onAuthorizer: onAuthorizer,
      );
      myChannel = await pusher.subscribe(channelName: _channelName.text);
      debugPrint(myChannel!.channelName);
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    debugPrint(event.data);
    debugPrint(event.eventName);
    debugPrint(event.channelName);
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = myChannel!.channelName;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    debugPrint('$channelName, $socketId, $options');
    String? token = '1052|pa8gWm2yKdhkOa8G4LTKSvJO1PL5jfSKhehCd9Cs';

    var authUrl = '${ApiUrls.baseUrl}channelAuthorization';
    var result = await post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
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

  void onTriggerEventPressed() async {
    var eventFormValidated = _eventFormKey.currentState!.validate();

    if (!eventFormValidated) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("eventName", _eventName.text);
    prefs.setString("data", _data.text);
    debugPrint(_channelName.text);
    pusher
        .trigger(PusherEvent(
          channelName: myChannel!.channelName,
          eventName: _eventName.text,
          data: _data.text,
        ))
        .whenComplete(() => debugPrint(_data.text));
    print(pusher.onAuthorizer);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey.text = prefs.getString("apiKey") ?? '';
      _cluster.text = prefs.getString("cluster") ?? 'eu';
      _channelName.text = prefs.getString("channelName") ?? 'my-channel';
      _eventName.text = prefs.getString("eventName") ?? 'client-event';
      _data.text = prefs.getString("data") ?? 'test';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(pusher.connectionState == 'DISCONNECTED'
              ? 'Pusher Channels Example'
              : _channelName.text),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              controller: _listViewController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                if (pusher.connectionState != 'CONNECTED')
                  Form(
                      key: _channelFormKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          controller: _channelName,
                          validator: (String? value) {
                            return (value != null && value.isEmpty)
                                ? 'Please enter your channel name.'
                                : null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Channel',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onConnectPressed,
                          child: const Text('Connect'),
                        )
                      ]))
                else
                  Form(
                    key: _eventFormKey,
                    child: Column(children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: pusher
                              .channels[_channelName.text]?.members.length,
                          itemBuilder: (context, index) {
                            final member =
                                pusher.channels[_channelName.text]!.members;
                            return ListTile(
                                title: Text(member[index]!.userInfo.toString()),
                                subtitle: Text(member[index]!.userId));
                          }),
                      TextFormField(
                        controller: _eventName,
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'Please enter your event name.'
                              : null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Event',
                        ),
                      ),
                      TextFormField(
                        controller: _data,
                        decoration: const InputDecoration(
                          labelText: 'Data',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onTriggerEventPressed,
                        child: const Text('Trigger Event'),
                      ),
                    ]),
                  ),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: Text(_log)),
              ]),
        ),
      ),
    );
  }
}
