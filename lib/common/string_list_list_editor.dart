// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';

class StringListListTextEditor extends StatefulWidget {
  const StringListListTextEditor({
    required this.tips,
    required this.leftHeader,
    required this.rightHeader,
    this.fontSize = 20,
    this.defaultLeftValues = const [],
    this.defaultRightValues = const [],
    this.defaultLeftRightMap = const {},
    this.onAdd,
    this.onDelete,
    this.onUpdate,
    super.key,
  });

  final double fontSize;
  final String tips;
  final String leftHeader;
  final String rightHeader;
  final List<String> defaultLeftValues;
  final List<String> defaultRightValues;
  final Map<String, String> defaultLeftRightMap;
  final void Function(String left, String right)? onAdd;
  final void Function(String left, String right)? onUpdate;
  final void Function(String left)? onDelete;

  @override
  State<StringListListTextEditor> createState() =>
      _StringListListTextEditorState();
}

class _StringListListTextEditorState extends State<StringListListTextEditor> {
  final valuesNotifier = ValueNotifier<List<String>>([]);
  final TextEditingController controller = TextEditingController();

  TextStyle get textStyle => TextStyle(
        color: Colors.black,
        fontSize: widget.fontSize,
      );

  @override
  void initState() {
    super.initState();

    valuesNotifier.value.addAll(List<String>.from(widget.defaultLeftValues));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          editor(),
          const SizedBox(height: 10),
          LayoutBuilder(builder: (context, constraints) {
            return listview(constraints.maxWidth);
          }),
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

  Widget listview(double width) {
    return ValueListenableBuilder(
      valueListenable: valuesNotifier,
      builder: (context, defaultLeftValues, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: defaultLeftValues.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                width: width,
                height: 8.r * 2 + widget.fontSize,
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.leftHeader,
                      style: textStyle,
                    ),
                    Text(
                      widget.rightHeader,
                      style: textStyle,
                    ),
                  ],
                ),
              );
            }

            final dataIndex = index - 1;
            final leftValue = defaultLeftValues[dataIndex];
            final rightValue = widget.defaultLeftRightMap[leftValue] ??
                (widget.defaultRightValues.isEmpty
                    ? ''
                    : widget.defaultRightValues.first);
            return Stack(
              children: [
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: [
                      Text(
                        leftValue,
                        style: textStyle,
                      ),
                      const Expanded(child: SizedBox()),
                      XDropdownButton<String>(
                        title: '',
                        defaultValue: rightValue,
                        itemValues: widget.defaultRightValues,
                        onChanged: (String newRightValue) {
                          widget.onUpdate?.call(
                            leftValue,
                            newRightValue,
                          );
                        },
                        widgetBuilder: (String value) {
                          return Text(value, style: textStyle);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close, size: widget.fontSize),
                        onPressed: () => _removeValue(dataIndex),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addString(String id) {
    if (id.isNotEmpty) {
      widget.onAdd?.call(
        id,
        widget.defaultRightValues.isEmpty
            ? ''
            : widget.defaultRightValues.first,
      );

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
