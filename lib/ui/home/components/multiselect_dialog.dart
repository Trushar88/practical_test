// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:practical_test/app/config/app_colors.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDialog({super.key, required this.items, required this.onSelectionChanged});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  final Set<String> _selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                selectedTileColor: APPCOLOR.PRIMARYCOLOR,
                activeColor: APPCOLOR.PRIMARYCOLOR,
                title: Text(widget.items[index]),
                value: _selectedItems.contains(widget.items[index]),
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected == true) {
                      _selectedItems.add(widget.items[index]);
                    } else {
                      _selectedItems.remove(widget.items[index]);
                    }
                    widget.onSelectionChanged(_selectedItems.toList());
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
