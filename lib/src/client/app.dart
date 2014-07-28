library application;

import 'package:polymer/polymer.dart';
import 'package:core_elements/core_animation.dart';
import 'dart:html';
import 'dart:async';
import 'package:woven/src/shared/model/user.dart';

class App extends Observable {
  @observable var selectedItem;
  @observable var selectedPage = 0;
  @observable String pageTitle = "";
  @observable UserModel user;

  void changeTitle(String newTitle) {
    HtmlElement el;
    el = document.querySelector('body /deep/ #page-title');
    el.style.opacity = '0';
    new Timer(new Duration(milliseconds: 1000), () {
      pageTitle = newTitle;
      el.style.opacity = '1';
    });
  }
}


