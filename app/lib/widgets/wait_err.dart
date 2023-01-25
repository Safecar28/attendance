part of '../main.dart';

/// A widget that displays a [CircularProgressIndicator] while waiting for data.
class Wait extends StatelessWidget {
  const Wait({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

///To err is human; to forgive divine.
class Err extends StatelessWidget {
  const Err({Key? key, required this.err, required this.stack})
      : super(key: key);

  final Object err;
  final Object stack;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [Text('Error: $err'), Text('Stack: $stack')]));
  }
}
