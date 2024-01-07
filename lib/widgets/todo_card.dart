import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEditPage;
  final Function(String) deleteById;
  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateToEditPage,
      required this.deleteById});

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['title'] ?? 'No Title'),
        subtitle: Text(item['description'] ?? 'No Description'),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              //Edit the item
              navigateToEditPage(item);
            } else if (value == 'delete') {
              deleteById(id);
              //Delete and remove the item
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text("Delete"),
              )
            ];
          },
        ),
      ),
    );
  }
}
