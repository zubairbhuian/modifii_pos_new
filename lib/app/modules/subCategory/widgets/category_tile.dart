import 'package:flutter/material.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.sl,
    required this.title,
    required this.isActive,
    this.onStatusChanged,
    this.onEdit,
    this.onDelete,
  });

  final String sl;
  final String title;
  final bool isActive;
  final void Function(bool)? onStatusChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 350, child: MyCustomText(sl)),
        MyCustomText(
          title,
          fontSize: 18,
        ),
        const SizedBox(width: 128),
        // Switch(
        //   value: isActive,
        //   onChanged: onStatusChanged,
        // ),
        const Spacer(),
        Row(
          children: [
            IconButton(
                onPressed: onEdit,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blueAccent,
                )),
            IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                )),
          ],
        )
      ],
    );
  }
}
