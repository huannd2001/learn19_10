import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:leanr_19_10/screens/firebase_screen.dart';
import 'package:leanr_19_10/screens/google_maps_screen.dart';
import 'package:leanr_19_10/screens/lottie_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // init();
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
    //   String? title = remoteMessage.notification?.title;
    //   String? description = remoteMessage.notification?.body;
    //   print(title);
    //   print(description);
    //   //im gonna have an alertdialog when clicking from push notification
    //   Alert(
    //     context: context,
    //     type: AlertType.none,
    //     title: title,
    //     desc: description,
    //     buttons: [
    //       DialogButton(
    //         onPressed: () => Navigator.pop(context),
    //         width: 120,
    //         child: const Text(
    //           "Back",
    //           style: TextStyle(color: Colors.white, fontSize: 20),
    //         ),
    //       )
    //     ],
    //   ).show();
    // });
  }

  void init() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) {
        setState(() {});
        print('thông báo');
        if (message != null) {
          String? title = message.notification?.title;
          String? description = message.notification?.body;
          print(title);
          print(description);
          //im gonna have an alertdialog when clicking from push notification
          Alert(
            context: context,
            type: AlertType.none,
            title: title,
            desc: description,
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
        }
      },
    );
  }

  void openNotification() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) {
        if (message != null) {
          String? title = message.notification?.title;
          String? description = message.notification?.body;
          print(title);
          print(description);
          //im gonna have an alertdialog when clicking from push notification
          Alert(
            context: context,
            type: AlertType.none,
            title: title,
            desc: description,
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
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // openNotification();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LottieScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const Center(
                    child: Text('Lottie'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GoogleMapsScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('Google Maps'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirebaseScreen(),
                    ),
                  );
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
            ],
          ),
        ),
      ),
    );
  }
}
