import 'package:flutter/material.dart';
import 'package:marian/presentation/pages/pin_login/pin_login_page.dart';
import 'package:marian/presentation/pages/task_list/task_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGatePage extends StatefulWidget {
  const AuthGatePage({super.key});

  @override
  State<AuthGatePage> createState() => _AuthGatePageState();
}

class _AuthGatePageState extends State<AuthGatePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state) {
      case AppLifecycleState.resumed:
        _resumed();
        break;

      case AppLifecycleState.paused:
        _paused();
        break;

      case AppLifecycleState.inactive:
        _inactive();
        break;

      default:
        break;
    }
  }

  final lastKnownStateKey = 'lastKnownStateKey';
  final backgroundedTimeKey = 'backgroundedTimeKey';

  Future _paused() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt(lastKnownStateKey, AppLifecycleState.paused.index);
  }

  Future _inactive() async {
    final sharedPref = await SharedPreferences.getInstance();
    final prevState = sharedPref.getInt(lastKnownStateKey);

    final prevStateIsNotPaused = prevState != null &&
        AppLifecycleState.values[prevState] != AppLifecycleState.paused;

    if (prevStateIsNotPaused) {
      sharedPref.setInt(backgroundedTimeKey, DateTime.now().millisecondsSinceEpoch);
    }

    sharedPref.setInt(lastKnownStateKey, AppLifecycleState.inactive.index);
  }

  Future _resumed() async {
    final sharedPref = await SharedPreferences.getInstance();

    final bgTime = sharedPref.getInt(backgroundedTimeKey) ?? 0;
    final allowedBackgroundTime = bgTime + 10000;
    final shouldShowPIN = DateTime.now().millisecondsSinceEpoch > allowedBackgroundTime;

    if (shouldShowPIN && context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PinLoginPage()));
    }

    sharedPref.remove(backgroundedTimeKey);
    sharedPref.setInt(lastKnownStateKey, AppLifecycleState.resumed.index);
  }

  @override
  Widget build(BuildContext context) {
    return const TaskListPage();
  }

}
