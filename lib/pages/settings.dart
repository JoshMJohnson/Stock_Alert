import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: body(),
    );
  }

  /* header widget of settings page */
  AppBar header(BuildContext context) {
    return AppBar(
      title: Text(
        'Settings',
        style: TextStyle(
            color: Colors.green[900],
            fontSize: 28,
            fontWeight: FontWeight.w900),
      ),
      centerTitle: false,
      backgroundColor: Colors.green[200],
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 35,
          color: Colors.green[900],
        ),
      ),
    );
  }

  /* body widget of settings page */
  Column body() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Notifications:',
                    style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Radio(
                            value: 'On',
                            groupValue: notificationsOn,
                            onChanged: (value) {
                              setState(() {
                                notificationsOn = !notificationsOn;
                              });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('On'),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Radio(
                            value: 'On',
                            groupValue: notificationsOn,
                            onChanged: (value) {
                              setState(() {
                                notificationsOn = !notificationsOn;
                              });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Off'),
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
