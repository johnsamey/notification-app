// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

void foregroundNotificationHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Foreground message received: ${message.notification?.title}");

    DatabaseReference messageRef = FirebaseDatabase.instance.ref("message");

    await messageRef.push().set({
      'title': message.notification?.title,
      'body': message.notification?.body,
      'date': message.sentTime.toString(),
    });
  } catch (e) {
    print(e.toString());
  }
}

@pragma('vm:entry-point')
Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    DatabaseReference notificationsRef = FirebaseDatabase.instance.ref("notifications");


    await notificationsRef.push().set({
      'title': message.notification?.title,
      'body': message.notification?.body,
      'date': message.sentTime.toString(),
    });
  } catch (e) {
    print(e.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // String? token = await FirebaseMessaging.instance.getToken();
  // print('token = $token');

  FirebaseMessaging.onMessage.listen(foregroundNotificationHandler);

  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken;
  final List<String> topics = ['news', 'sports', 'technology'];
  final Set<String> subscribedTopics = {};

  @override
  void initState() {
    super.initState();
    _initializeMessaging();
  }

  Future<void> _initializeMessaging() async {
    // Get device token
    deviceToken = await _firebaseMessaging.getToken();
    print("Device Token: $deviceToken");

    // Handle notifications while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");
      _showNotificationDialog(message.notification?.title, message.notification?.body);
    });
  }

  void _showNotificationDialog(String? title, String? body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Notification'),
        content: Text(body ?? 'No content'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    setState(() {
      subscribedTopics.add(topic);
    });
    print("Subscribed to $topic");
  }

  void _unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    setState(() {
      subscribedTopics.remove(topic);
    });
    print("Unsubscribed from $topic");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Topics Subscription'),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          final isSubscribed = subscribedTopics.contains(topic);
          return ListTile(
            title: Text(topic),
            trailing: isSubscribed
                ? ElevatedButton(
                    onPressed: () => _unsubscribeFromTopic(topic),
                    child: const Text('Unsubscribe'),
                  )
                : ElevatedButton(
                    onPressed: () => _subscribeToTopic(topic),
                    child: const Text('Subscribe'),
                  ),
          );
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Topic Notifications"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Topic Notification Example',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   FirebaseMessaging.instance.subscribeToTopic("news").then((_) {
//                     print("Subscribed to 'news' topic from phone");
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text("Subscribed to 'news' topic"),
//                     ));
//                   });
//                 },
//                 child: const Text("Subscribe to 'news'"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   FirebaseMessaging.instance
//                       .unsubscribeFromTopic("news")
//                       .then((_) {
//                     print("Unsubscribed from 'news' topic");
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text("Unsubscribed from 'news' topic"),
//                     ));
//                   });
//                 },
//                 child: const Text("Unsubscribe from 'news'"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//   static List<String> topics = ["news", "sports", "technology"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notification Topics')),
//       body: ListView.builder(
//         itemCount: topics.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(topics[index]),
//             trailing: ElevatedButton(
//               onPressed: () async {
//                 await FirebaseMessaging.instance.subscribeToTopic(topics[index]);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Subscribed to ${topics[index]}')),
//                 );
//               },
//               child: Text('Subscribe'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// f_8qPdMSSd2QdTeJysdL00:APA91bFybxECxGJRGMkB_1X0YJ7-7mXL1icdHtDd_VrIc3dEgLdx9UcHjiTeb8-63McIBRSw3bgR8FW8jBIUPWQHwAY588yYXdpnzxhSsx_fsWRfPolJjQM