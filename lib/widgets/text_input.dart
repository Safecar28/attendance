part of '../main.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.label,
    required this.value,
    required this.setState,
  }) : super(key: key);

  final String label;
  final String value;
  final void Function(String) setState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        initialValue: value,
        onChanged: setState,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(), labelText: label),
      ),
    );
  }
}
