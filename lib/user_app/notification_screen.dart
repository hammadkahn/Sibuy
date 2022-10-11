import 'package:flutter/material.dart';
import 'package:SiBuy/models/notification.dart';
import 'package:SiBuy/services/notification_services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: FutureBuilder<NotificationModel>(
          future: NotificationServices().getNotifications(token: token),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.data!.data!.isEmpty) {
                  return const Center(child: Text('No deals available'));
                } else {
                  print(snapshot.data!.data!.length);
                  return GroupedListView<Data, DateTime>(
                    elements: snapshot.data!.data!,
                    order: GroupedListOrder.DESC,
                    reverse: true,
                    floatingHeader: true,
                    useStickyGroupSeparators: true,
                    groupBy: (Data element) {
                      DateTime notificatonDate =
                          DateTime.parse(element.createdAt!);

                      return DateTime(
                        notificatonDate.year,
                        notificatonDate.month,
                        notificatonDate.day,
                      );
                    },
                    groupHeaderBuilder: _createGroupHeader,
                    itemBuilder: (_, Data element) =>
                        _createItem(context, element),
                  );
                  // ListView.builder(
                  //   itemCount: snapshot.data!.data!.length,
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     var data = snapshot.data!.data![index];
                  //     return;
                  //   },
                  // );
                }
            }
          },
        ),
      ),
    );
  }

  Widget _createItem(BuildContext ctx, Data element) {
    return InkWell(
        hoverColor: Colors.orange,
        onTap: () => showsimple(ctx, element),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            iconColor: Colors.white,
            contentPadding: const EdgeInsets.all(10),
            textColor: Colors.white,
            tileColor: const Color(0xFFff6600),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: const Icon(Icons.notifications),
            title: Text(element.subject!),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.message!),
                Text(element.type!),
                Text(element.seen == '0' ? 'Not seen' : 'Seen'),
                const Divider(
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _createGroupHeader(Data element) {
    return SizedBox(
      height: 40,
      child: Align(
        child: Container(
          width: 120,
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.yMMMd().format(DateTime.parse(element.createdAt!)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void showsimple(BuildContext context, Data data) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data.subject ?? 'Notification'),
          content: RichText(
            text: TextSpan(
                text: '${data.message ?? 'no message'}\n\n',
                style: const TextStyle(
                  color: Color(0xffff6600),
                ),
                children: [
                  TextSpan(
                      text: 'type: ${data.type ?? 'type not specified'}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 90, 154, 199)))
                ]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
