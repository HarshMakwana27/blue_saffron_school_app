import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/widgets/attendance_tile.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:url_launcher/url_launcher_string.dart';

class ContactCard extends StatefulWidget {
  const ContactCard(this.user, {super.key});

  final Map<String, dynamic> user;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  _showCallOptionsDialog(String number) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Do you want to call the user?',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: number));
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Copy'),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      icon: const Icon(Icons.call),
                      onPressed: () {
                        _callNumber(number);
                        Navigator.pop(context); // Close the dialog
                      },
                      label: const Text('Call'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _openWhatsApp(String number) async {
    //To remove the keyboard when button is pressed
    FocusManager.instance.primaryFocus?.unfocus();

    var whatsappUrl = "whatsapp://send?phone=${'+91$number'}";
    try {
      launchUrlString(whatsappUrl);
    } catch (e) {
      //To handle error and display error message
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${widget.user['name']}'.capitalize(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Text(
                  widget.user['isStudent'] ? 'Parent' : 'Teacher',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/WhatsApp_icon.png',
                  width: 30,
                ),
                TextButton(
                  onPressed: () {
                    _openWhatsApp(
                      '${widget.user['number']}',
                    );
                  },
                  child: const Text('Send message'),
                ),
                const Icon(
                  CupertinoIcons.arrow_up_right,
                  size: 12,
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 2,
                ),
                TextButton(
                  onPressed: () {
                    _showCallOptionsDialog('${widget.user['number']}');
                  },
                  child: Text(' call ${widget.user['number']}'),
                ),
                const Icon(
                  CupertinoIcons.arrow_up_right,
                  size: 12,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
