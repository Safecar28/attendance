part of 'package:attendance/main.dart';

final loginProvider =
    Provider<bool>(((ref) => FirebaseAuth.instance.currentUser != null));

class Login extends ConsumerWidget {
  Login({Key? key}) : super(key: key);
  final _providers = <auth_ui.AuthProvider>[auth_ui.PhoneAuthProvider()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginProvider);
    return login
        ? const HomePage(title: 'Homerooms')
        : auth_ui.SignInScreen(providers: _providers);
  }
}
