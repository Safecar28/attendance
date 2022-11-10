part of '../main.dart';

class Wait extends StatelessWidget {
  const Wait({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class Err extends StatelessWidget {
  const Err({Key? key, required this.err}) : super(key: key);

  final Object err;

  @override
  Widget build(BuildContext context) {
    return Text('Error: $err');
  }
}
