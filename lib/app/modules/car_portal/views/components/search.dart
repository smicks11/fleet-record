import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final TextEditingController _controller = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _showDropdownDialog() {
    showDialog(
      context: context,
      builder: (context) => DropdownSearchDialog(
        items: widget.items,
        initialValue: widget.value,
        onItemSelected: widget.onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: _showDropdownDialog,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.withOpacity(0.6), width: 1.5),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.value ?? "Select", style: TextStyle(fontSize: 12)),
                Icon(Icons.keyboard_arrow_down, color: Colors.black38),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DropdownSearchDialog extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String) onItemSelected;

  const DropdownSearchDialog({
    required this.items,
    required this.initialValue,
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);

  @override
  _DropdownSearchDialogState createState() => _DropdownSearchDialogState();
}

class _DropdownSearchDialogState extends State<DropdownSearchDialog> {
  late TextEditingController searchController;
  late List<String> filteredItems;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems = widget.items;
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 700,
        height: 700,
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red.withOpacity(0.6), width: 1.5),
                ),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              ),
              onChanged: filterItems,
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
                    onTap: () {
                      widget.onItemSelected(filteredItems[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
