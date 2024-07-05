/*
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class pushNotificationService extends StatefulWidget {
  @override
  _PushNotificationServiceState createState() => _PushNotificationServiceState();
}

class _PushNotificationServiceState extends State<pushNotificationService> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    await _messaging.requestPermission();
    bool enabled = await _areNotificationsEnabled();
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  Future<bool> _areNotificationsEnabled() async {
    NotificationSettings settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void _toggleNotifications() async {
    if (_notificationsEnabled) {
      await _messaging.unsubscribeFromTopic('all');
    } else {
      await _messaging.subscribeToTopic('all');
    }
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _notificationsEnabled ? 'Notifications are ON' : 'Notifications are OFF',
        ),
        Switch(
          value: _notificationsEnabled,
          onChanged: (value) {
            _toggleNotifications();
          },
        ),
      ],
    );
  }
}

 */
