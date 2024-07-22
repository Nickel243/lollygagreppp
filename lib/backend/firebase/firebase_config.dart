import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyALbHaxHT2ioBOBvrL8KQ6PNHb8FJeQy7w",
            authDomain: "lollygag-0kwkjo.firebaseapp.com",
            projectId: "lollygag-0kwkjo",
            storageBucket: "lollygag-0kwkjo.appspot.com",
            messagingSenderId: "1005080189757",
            appId: "1:1005080189757:web:c1faa7d54abc55b1ea8354"));
  } else {
    await Firebase.initializeApp();
  }
}
