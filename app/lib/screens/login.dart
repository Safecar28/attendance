part of 'package:attendance/main.dart';

final loginProvider = Provider<bool>(
  // ((ref) => FirebaseAuth.instance.currentUser != null),
  (ref) => true,
);

/// AuthProvider list.
final _providers = <auth_ui.AuthProvider>[auth_ui.PhoneAuthProvider()];

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginProvider);
    return login
        ? const HomePage(title: 'Homerooms')
        : loginScreen(
            context,
            // ref,
          );
    // : auth_ui.SignInScreen(
    //     providers: _providers,
    //     headerBuilder: (context, constraints, shrinkOffset) {
    //       return Container(
    //         color: Colors.indigo,
    //         child: const Center(
    //           child: Text(
    //             'Welcome to Attendance!',
    //             style: TextStyle(color: Colors.white, fontSize: 24),
    //           ),
    //         ),
    //       );
    //     },
    //     headerMaxExtent: 100,
    //     footerBuilder: (context, action) => const Text(
    //       'Please contact the school administrator if you have any issues.',
    //       style: TextStyle(color: Colors.black),
    //     ),
    //     showAuthActionSwitch: false,
    //     resizeToAvoidBottomInset: true,
    //     desktopLayoutDirection: TextDirection.rtl,
    //   );
  }
}

@Deprecated('unused')
final auth_ui.LoginView myLoginView = auth_ui.LoginView(
  action: auth_ui.AuthAction.signIn,
  providers: _providers,
  footerBuilder: (context, action) => const Text(
    'Please contact the school administrator if you have any issues.',
    style: TextStyle(color: Colors.white),
  ),
  showAuthActionSwitch: false,
);

/// A login screen using sign in provider that has a black background and text styled with Ubuntu font
// ignore: prefer_function_declarations_over_variables
Widget loginScreen(
  BuildContext context,
  // WidgetRef ref,
) {
  return auth_ui.SignInScreen(
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
    desktopLayoutDirection: TextDirection.rtl,
  );
}
