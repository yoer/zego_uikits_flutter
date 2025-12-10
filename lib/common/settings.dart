// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget settingsGroup(String groupName, List<Widget> children) {
  return Container(
    margin: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0.r),
      border: Border.all(color: Colors.blue),
      color: Colors.white,
    ),
    child: Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupName,
            style: TextStyle(
              fontSize: 20.r,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...children,
        ],
      ),
    ),
  );
}

Widget settingsLine() {
  return Container(
    color: Colors.black.withValues(alpha: 0.2),
    height: 1,
    margin: EdgeInsets.all(20.r),
  );
}

TextStyle settingsTextStyle = TextStyle(
  fontSize: 20.r,
  fontWeight: FontWeight.bold,
);
Widget settingsCheckBox({
  required String title,
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return CheckboxListTile(
    title: Text(title, style: settingsTextStyle),
    value: value,
    activeColor: Colors.green,
    onChanged: onChanged,
  );
}

Widget settingsEditor({
  required String tips,
  required String value,
  required ValueChanged<String> onChanged,
}) {
  return Container(
    margin: EdgeInsets.all(10.r),
    child: TextField(
      style: settingsTextStyle,
      decoration: InputDecoration(
        labelText: tips,
        labelStyle: settingsTextStyle,
        hintText: value,
        hintStyle: settingsTextStyle,
        border: const OutlineInputBorder(),
      ),
      onChanged: (String value) {
        onChanged.call(value);
      },
    ),
  );
}

Widget settingsIntEditor({
  required String tips,
  required int value,
  required ValueChanged<int> onChanged,
}) {
  return Container(
    margin: EdgeInsets.all(10.r),
    child: TextField(
      style: settingsTextStyle,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: tips,
        labelStyle: settingsTextStyle,
        hintText: value.toString(),
        hintStyle: settingsTextStyle,
        border: const OutlineInputBorder(),
      ),
      onChanged: (String value) {
        final intValue = int.tryParse(value);
        if (intValue != null) {
          onChanged.call(intValue);
        }
      },
    ),
  );
}

Widget settingsDoubleEditor({
  required String tips,
  required double value,
  required ValueChanged<double> onChanged,
}) {
  return Container(
    margin: EdgeInsets.all(10.r),
    child: TextField(
      style: settingsTextStyle,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: tips,
        labelStyle: settingsTextStyle,
        hintText: value.toString(),
        hintStyle: settingsTextStyle,
        border: const OutlineInputBorder(),
      ),
      onChanged: (String value) {
        final doubleValue = double.tryParse(value);
        if (doubleValue != null) {
          onChanged.call(doubleValue);
        }
      },
    ),
  );
}

Widget settingsRadio<T>({
  required String title,
  required T defaultValue,
  required List<T> items,
  required ValueChanged<T> onChanged,
}) {
  return RadioGroup<T>(
    title: title,
    value: defaultValue,
    items: items,
    onChanged: onChanged,
  );
}

Widget settingSwitchDropList<T>({
  required String title,
  required T defaultValue,
  required List<T> itemValues,
  required ValueChanged<T> onChanged,
  required Widget Function(T value) widgetBuilder,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.r),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: settingsTextStyle),
        XDropdownButton<T>(
          title: title,
          defaultValue: defaultValue,
          itemValues: itemValues,
          onChanged: onChanged,
          widgetBuilder: widgetBuilder,
        ),
      ],
    ),
  );
}

class XDropdownButton<T> extends StatefulWidget {
  const XDropdownButton({
    super.key,
    required this.title,
    required this.defaultValue,
    required this.itemValues,
    required this.onChanged,
    required this.widgetBuilder,
  });

  final String title;
  final T defaultValue;
  final List<T> itemValues;
  final ValueChanged<T> onChanged;
  final Widget Function(T value) widgetBuilder;

  @override
  State<XDropdownButton<T>> createState() {
    return _XDropdownButtonState<T>();
  }
}

class _XDropdownButtonState<T> extends State<XDropdownButton<T>> {
  late ValueNotifier<T> currentValueNotifier;

  @override
  void initState() {
    super.initState();

    currentValueNotifier = ValueNotifier<T>(widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: currentValueNotifier,
      builder: (context, value, _) {
        return DropdownButton<T>(
          value: widget.defaultValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: widget.itemValues.map((T itemValue) {
            return DropdownMenuItem<T>(
              value: itemValue,
              child: widget.widgetBuilder(itemValue),
            );
          }).toList(),
          onChanged: (T? newValue) {
            if (newValue != null) {
              setState(() {
                widget.onChanged(newValue);

                currentValueNotifier.value = newValue;
              });
            }
          },
        );
      },
    );
  }
}

class RadioGroup<T> extends StatefulWidget {
  const RadioGroup({
    super.key,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final T value;
  final List<T> items;
  final ValueChanged<T> onChanged;

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: settingsTextStyle,
          ),
          ...widget.items.map((item) {
            return RadioListTile<T>(
              title: Text(item.toString(), style: settingsTextStyle),
              value: item,
              groupValue: widget.value,
              onChanged: (T? newValue) {
                if (newValue != null) {
                  widget.onChanged(newValue);
                }
              },
              activeColor: Colors.green,
            );
          }),
        ],
      ),
    );
  }
}
