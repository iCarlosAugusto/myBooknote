import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.name, required this.professor,required this.selected, required this.onLongPress, required this.onTap});

  final String name;
  final String professor;
  final bool selected;
  final Function() onLongPress;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        selected: selected,
        leading: const Icon(Icons.menu_book_rounded),
        title: Text(name),
        subtitle: Text(professor),
        trailing: const Icon(Icons.arrow_forward_ios_rounded)
      ),
    );
  }
}