import 'package:applozic_example/auth/login.dart';
import 'package:applozic_flutter/applozic_flutter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: ApplozicFlutter.getLoggedInUserId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Logged in User ID is ${snapshot.data!}',
                    style: Theme.of(context).textTheme.headline6,
                  );
                }
                return const Text('Loading ...');
              },
            ),
            const SizedBox(height: 32.0),
            TextField(
              decoration: const InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.all(16.0),
                hintText: 'User ID',
              ),
              onChanged: (String? text) {
                setState(() {
                  userId = text;
                });
              },
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  ApplozicFlutter.launchChatScreen();
                },
                child: const Text(
                  'Open Chat Screen',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  ApplozicFlutter.launchChatWithUser(userId);
                },
                child: const Text(
                  'Open User Chat Screen',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () async {
                  final int unread =
                      await ApplozicFlutter.getUnreadChatsCount();
                  final int unreadMessages =
                      await ApplozicFlutter.getTotalUnreadCount();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Your unread count is $unreadMessages from $unread chats!'),
                      duration: const Duration(milliseconds: 1500),
                      width: 380.0, // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Get unread chats count',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          ApplozicFlutter.logout();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const LoginPage()));
        },
      ),
    );
  }
}
