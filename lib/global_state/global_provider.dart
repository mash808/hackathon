import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalProvider = StateNotifierProvider<LoggedIn, bool>((ref) {
  return LoggedIn();
});

final indexProvider = StateNotifierProvider<PageIndex, int>((ref) {
  return PageIndex();
});

class PageIndex extends StateNotifier<int> {
  PageIndex() : super(3);
  void updateIndex(int index) {
    state = index;
  }
}

class LoggedIn extends StateNotifier<bool> {
  LoggedIn() : super(false);
  void logIn() {
    state = true;
  }
}
