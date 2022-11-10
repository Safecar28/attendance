part of '../main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  build(context, ref) => ref.watch(homeroomsProvider).when(
      loading: () => const Wait(),
      error: (err, stack) => const Wait(),
      data: (homerooms) {
        return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {},
                ),
              ],
            ),
            body: HomeroomList(homerooms: homerooms));
      });
}
