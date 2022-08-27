import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalProvider = StateNotifierProvider<LoggedIn, bool>((ref) {
  return LoggedIn();
});

final indexProvider = StateNotifierProvider<PageIndex, int>((ref) {
  return PageIndex();
});

final nameProvider = StateNotifierProvider<SetName, String>((ref) {
  return SetName();
});

class SetName extends StateNotifier<String> {
  SetName() : super('Guest123');
  void setName(String username) {
    state = username;
  }
}

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

  void logout() {
    state = false;
  }
}
