import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';

class MessageItem extends StatelessWidget {
  final bool send;
  final String? message;
  final String? url1;

  const MessageItem(
      {Key? key, required this.send, required this.message, this.url1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(right: 13, left: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            send ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Visibility(
              visible: !send,
              child: url1!.isEmpty || url1 == ''
                  ? CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/man1.png',
                        fit: BoxFit.fill,
                      ))
                  : CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(url1!))),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                left: !send ? 5 : (MediaQuery.of(context).size.width / 2) - 80,
                right: send ? 5 : (MediaQuery.of(context).size.width / 2) - 80,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(send ? 20 : 0),
                  bottomRight: Radius.circular(send ? 0 : 20),
                ),
                color: send
                    ? AppColors.APP_PRIMARY_COLOR
                    : const Color(0xFFE9E9E9).withOpacity(0.8),
              ),
              child: SelectableText(
                message ?? '',
                style: TextStyle(
                    color: send ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Mulish'),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Visibility(
            visible: send,
            child: url1!.isEmpty || url1 == ''
                ? CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/images/man2.png',
                      fit: BoxFit.fill,
                    ),
                  )
                : CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(url1!)),
          ),
        ],
      ),
    );
  }
}
