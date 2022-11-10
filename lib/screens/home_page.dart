part of '../main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  void Function() addHomeroom(BuildContext context) {
    return () {
      Navigator.push(
          context,
          MaterialPageRoute<Widget>(
              fullscreenDialog: true,
              builder: (context) => const HomeroomForm()));
    };
  }

  @override
  build(context, ref) => ref.watch(homeroomsProvider).when(
      loading: () => const Wait(),
      error: (err, stack) => Err(err: err),
      data: (homerooms) {
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_home),
                  onPressed: addHomeroom(context),
                ),
              ],
            ),
            body: HomeroomList(
              homerooms: homerooms,
              add: addHomeroom(context),
            ));
      });
}
