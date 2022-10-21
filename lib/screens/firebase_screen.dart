import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({super.key});

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("###########");
    print(deviceToken);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {

        Alert(
          context: context,
          type: AlertType.none,
          title: message.notification?.title,
          desc: message.notification?.body,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              const snackBarTest = SnackBar(content: Text("huan1"));
              ScaffoldMessenger.of(context).showSnackBar(snackBarTest);
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: const BoxDecoration(color: Colors.purple),
              child: const Center(
                child: Text('Firebase'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessaging.getToken();
    return (deviceToken == null) ? '' : deviceToken;
  }
}
