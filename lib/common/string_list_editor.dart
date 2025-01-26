// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StringListTextEditor extends StatefulWidget {
  const StringListTextEditor({
    required this.tips,
    this.fontSize = 20,
    this.defaultValues = const [],
    this.onAdd,
    this.onDelete,
    super.key,
  });

  final double fontSize;
  final String tips;
  final List<String> defaultValues;
  final void Function(String)? onAdd;
  final void Function(String)? onDelete;

  @override
  State<StringListTextEditor> createState() => _StringListTextEditorState();
}

class _StringListTextEditorState extends State<StringListTextEditor> {
  final valuesNotifier = ValueNotifier<List<String>>([]);
  final TextEditingController controller = TextEditingController();

  TextStyle get textStyle => TextStyle(
        color: Colors.black,
        fontSize: widget.fontSize,
      );

  @override
  void initState() {
    super.initState();

    valuesNotifier.value.addAll(List<String>.from(widget.defaultValues));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          editor(),
          const SizedBox(height: 10),
          listview(),
        ],
      ),
    );
  }

  Widget editor() {
    return TextField(
      controller: controller,
      style: textStyle,
      onSubmitted: _addString,
      decoration: InputDecoration(
        labelText: widget.tips,
        labelStyle: textStyle,
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            return IconButton(
              icon: Icon(
                Icons.add,
                color: value.text.isEmpty ? Colors.grey : Colors.green,
              ),
              onPressed: () =>
                  value.text.isEmpty ? null : _addString(controller.text),
            );
          },
        ),
      ),
    );
  }

  Widget listview() {
    return ValueListenableBuilder(
      valueListenable: valuesNotifier,
      builder: (context, defaultValues, _) {
        return SizedBox(
          height: 100.r,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: defaultValues.length,
            itemBuilder: (context, index) {
              return IntrinsicWidth(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      constraints: const BoxConstraints(
                        minWidth: 100,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          defaultValues[index],
                          style: textStyle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, size: widget.fontSize),
                        onPressed: () => _removeValue(index),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _addString(String id) {
    if (id.isNotEmpty) {
      widget.onAdd?.call(id);

      valuesNotifier.value = [...valuesNotifier.value, id];
      controller.clear();
    }
  }

  void _removeValue(int index) {
    widget.onDelete?.call(valuesNotifier.value[index]);

    final oldValue = valuesNotifier.value;
    oldValue.removeAt(index);
    valuesNotifier.value = [...oldValue];
  }
}
