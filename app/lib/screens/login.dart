part of 'package:attendance/main.dart';

final loginProvider = Provider<bool>(
// ((ref) => FirebaseAuth.instance.currentUser != null),
  (ref) => true,
);

/// AuthProvider list.
final _providers = <authui.AuthProvider>[authui.PhoneAuthProvider()];

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var login = ref.watch<bool>(loginProvider);
    return login ? const HomePage(title: 'Homerooms') : loginScreen(context);
    // return loginScreen(context);
  }
}

@Deprecated('unused')
final authui.LoginView myLoginView = authui.LoginView(
  action: authui.AuthAction.signIn,
  providers: _providers,
  footerBuilder: (context, action) => const Text(
    'Please contact the school administrator if you have any issues.',
    style: TextStyle(color: Colors.white),
  ),
  showAuthActionSwitch: false,
);

/// A login screen using sign in provider that has a black background and text styled with Ubuntu font
// ignore: prefer_function_declarations_over_variables
Widget loginScreen(BuildContext context) {
  return authui.SignInScreen(
    providers: _providers,
    headerBuilder: (context, constraints, shrinkOffset) {
      return Container(
        color: Colors.indigo,
        child: const Center(
          child: Text(
            'Welcome to Attendance!',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      );
    },
    headerMaxExtent: 100,
    footerBuilder: (context, action) => const Text(
      'Please contact the school administrator if you have any issues.',
      style: TextStyle(color: Colors.black),
    ),
    showAuthActionSwitch: false,
    resizeToAvoidBottomInset: true,
    desktopLayoutDirection: TextDirection.ltr,
    actions: [
      authui.AuthStateChangeAction(
        (context, state) {
          state == true
              ? Navigator.pushNamed(context, '/homepage')
              : loginScreen(context);
        },
      )
    ],
  );
}
