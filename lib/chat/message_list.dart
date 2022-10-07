import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  // final msgCtr = TextEditingController();
  // PusherChannel? myChannel;
  // bool isChatStart = false;

  // void onConnectPressed() async {
  //   try {
  //     pusher.init(
  //       apiKey: '814fe1b741785e7ace5e',
  //       cluster: 'ap2',
  //       onAuthorizer: onAuthorizer,
  //     );
  //     myChannel =
  //         await pusher.subscribe(channelName: 'private-messages-channel.${19}');
  //     await pusher.connect();

  //     setState(() {
  //       isChatStart = true;
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // dynamic onAuthorizer(
  //     String channelName, String socketId, dynamic options) async {
  //   debugPrint('$channelName, $socketId, $options');

  //   var authUrl = '${ApiUrls.baseUrl}channelAuthorization';
  //   var result = await post(
  //     Uri.parse(authUrl),
  //     headers: {
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //       HttpHeaders.authorizationHeader: 'Bearer ${widget.token}',
  //     },
  //     body: 'socket_id=$socketId&channel_name=$channelName',
  //   );

  //   log('response : ${result.body}');

  //   return jsonDecode(result.body);
  // }

  // void onTriggerEventPressed(String msg, String eventName) async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // prefs.setString("eventName", _eventName.text);
  //   // prefs.setString("data", _data.text);

  //   pusher.trigger(PusherEvent(
  //     channelName: myChannel!.channelName,
  //     eventName: 'client-$eventName',
  //     data: msg,
  //   ));
  // }

  // _launchCaller() async {
  //   if (await canLaunchUrl(
  //       Uri.parse('https://gigifrontend.zanforthstaging.com/MobileChat'))) {
  //     await launchUrl(
  //         Uri.parse('https://gigifrontend.zanforthstaging.com/MobileChat'));
  //   } else {
  //     throw 'Could not launch the url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Link(
          target: LinkTarget.blank,
          uri: Uri.parse(
              'https://gigifrontend.zanforthstaging.com/MobileChatLogin'),
          builder: (context, followLink) => Center(
            child: TextButton(
              onPressed: followLink,
              child: const Text('Start Chat'),
            ),
          ),
        ),
      ),
    );
  }
}
