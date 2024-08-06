import 'package:flutter/material.dart';
import 'package:saurabh_naik_item_tracker/widget/common_elevated_button.dart';

class ItemListTile extends StatelessWidget {
  final String title;
  final String description;
  final void Function() onDelete;
  final void Function() onEdit;

  const ItemListTile({
    super.key,
    required this.title,
    required this.description,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: CommonElevatedButton(
                  onButtonTap: onDelete,
                  buttonColor: Colors.red,
                  buttonLabel: "Delete",
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CommonElevatedButton(
                  onButtonTap: onEdit,
                  buttonColor: Colors.green,
                  buttonLabel: "Edit",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
