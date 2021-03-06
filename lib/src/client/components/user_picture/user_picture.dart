library user_picture;

import "dart:html";

import 'package:polymer/polymer.dart';
import 'package:firebase/firebase.dart';

import 'package:woven/src/client/app.dart';
import 'package:woven/config/config.dart';

@CustomTag("user-picture")
class UserPicture extends PolymerElement {
  @published App app;
  @published String user;
  @observable Map userMap = toObservable({});

  var fb = new Firebase(config['datastore']['firebaseLocation']);

  UserPicture.created() : super.created();

  getUser() {
    if (user != null) {
      if (app.user != null && user == app.user.username) {
        // If we're trying to show the current user, we already know its details.
        userMap['fullPicturePath'] = app.user.fullPathToPicture;
      } else {
        fb.child('/users/$user').once('value').then((res) {
          userMap = res.val();
          if (userMap == null) return;
          userMap['fullPicturePath'] = (userMap != null && userMap['picture'] != null) ? '${config['google']['cloudStoragePath']}/${userMap['picture']}' : null;
        });
      }
    }
  }

  userChanged() {
    getUser();
  }

  attached() {
    getUser();
  }
}