import 'package:SiBuy/services/deals/merchant_deal_services.dart';
import 'package:flutter/material.dart';

class Request_pay extends StatefulWidget {
  const Request_pay({super.key, required this.token});
  final String token;

  @override
  State<Request_pay> createState() => _Request_payState();
}

class _Request_payState extends State<Request_pay> {
  final amountCtr = TextEditingController();
  final descriptionCtr = TextEditingController();
  final _key = GlobalKey<FormState>();

  ValueNotifier<Map<String, dynamic>>? data = ValueNotifier({});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFff6600),
        title: const Text('Request Payment'),
      ),
      body: Form(
        key: _key,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //two text forms with submit button
              const Text(
                'Amount',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: DealServices().getWithdrawDetails(widget.token),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        data!.value = snapshot.data!['data'];
                        amountCtr.text =
                            snapshot.data!['data']['totalBalance'].toString();
                        return TextFormField(
                          controller: amountCtr,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: amountCtr.text,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: descriptionCtr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add a description';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: ValueListenableBuilder(
                  valueListenable: data!,
                  builder: (BuildContext context, Map<String, dynamic> value,
                      Widget? child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFff6600),
                      ),
                      onPressed: data!.value.isEmpty ||
                              data!.value['deals'].isEmpty ||
                              data!.value['totalBalance'] == 0
                          ? null
                          : _paymentWithdrawal,
                      child: const Text('Submit'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _paymentWithdrawal() async {
    final result = await DealServices().withdrawPayment(
      widget.token,
      descriptionCtr.text,
    );

    if (result == '200') {
      await showWarning('Withdrawal request initiated');
    } else {
      await showWarning(result);
    }
  }

  Future<bool?> showWarning(String msg) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Api Response'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
        barrierDismissible: false,
      );
}
