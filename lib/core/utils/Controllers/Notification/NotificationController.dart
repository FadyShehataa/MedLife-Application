
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:core';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class CustomNotification {
  CustomNotification();

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    String? token = await messaging.getToken();
    FirebaseFirestore.instance.collection('users').doc('username').set({
      'token': token,
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> storeTokenOnUserLogin(String? userId) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    //get device token and store it in firestore under name patientId
    String? token = await messaging.getToken();
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'token': token,
    });
  }

  Future<String> getTokenFromFireStoreOnEvent(String? patientId) async {
    //retreive token from firestore using patientId
    String? token = await FirebaseFirestore.instance
        .collection('users')
        .doc(patientId)
        .get()
        .then((value) => value.get('token'));
    return token!;
  }
}
