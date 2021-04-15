import 'package:flutter/material.dart';

class PageManager{

  PageManager(this._pageController);

  final PageController _pageController;
  final Map<String, num> pages = {
    'login': 1,
    'signup': 2,
    'account': 3,
    'clients': 4,
    'projects': 5
  };

  int page = 0;

  void setPage( int value){
    if(value == page) return;
    page = value;
    _pageController.jumpToPage(value);
  }

}