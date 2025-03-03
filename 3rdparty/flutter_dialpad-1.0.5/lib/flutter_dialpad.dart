library flutter_dialpad;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_dtmf/dtmf.dart';

class DialPad extends StatefulWidget {
  /// true will clear
  final bool Function(String)? keyPressed;
  final ValueSetter<String>? valueUpdated;
  final bool? hideSubtitle;
  // buttonColor is the color of the button on the dial pad. defaults to Colors.gray
  final Color? buttonColor;
  final Color? buttonTextColor;

  final Widget Function(double sizeFactor)? audioDialButtonBuilder;
  final Color? videoDialButtonColor;
  final Color? videoDialButtonIconColor;
  final IconData? videoDialButtonIcon;
  final ValueSetter<String>? makeVideoCall;

  final Widget Function(double sizeFactor)? videoDialButtonBuilder;
  final Color? audioDialButtonColor;
  final Color? audioDialButtonIconColor;
  final IconData? audioDialButtonIcon;
  final ValueSetter<String>? makeAudioCall;

  final Color? backspaceButtonIconColor;
  final Color? dialOutputTextColor;
  // outputMask is the mask applied to the output text. Defaults to (000) 000-0000
  final String? outputMask;
  final bool? enableDtmf;

  const DialPad({
    Key? key,
    this.keyPressed,
    this.valueUpdated,
    this.hideSubtitle = false,
    this.outputMask,
    this.buttonColor,
    this.buttonTextColor,
    this.videoDialButtonBuilder,
    this.videoDialButtonColor,
    this.videoDialButtonIconColor,
    this.videoDialButtonIcon,
    this.makeVideoCall,
    this.audioDialButtonBuilder,
    this.audioDialButtonColor,
    this.audioDialButtonIconColor,
    this.audioDialButtonIcon,
    this.makeAudioCall,
    this.dialOutputTextColor,
    this.backspaceButtonIconColor,
    this.enableDtmf,
  }) : super(key: key);

  @override
  _DialPadState createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  MaskedTextController? textEditingController;
  var _value = "";
  var mainTitle = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "＃"];
  var subTitle = [
    "",
    "ABC",
    "DEF",
    "GHI",
    "JKL",
    "MNO",
    "PQRS",
    "TUV",
    "WXYZ",
    null,
    "+",
    null
  ];

  @override
  void initState() {
    textEditingController =
        MaskedTextController(mask: widget.outputMask ?? '(000) 000-0000');
    super.initState();
  }

  _setText(String? value) async {
    if ((widget.enableDtmf == null || widget.enableDtmf!) && value != null) {
      Dtmf.playTone(digits: value.trim(), samplingRate: 8000, durationMs: 160);
    }

    setState(() {
      _value += value!;

      textEditingController!.text = _value;
      widget.valueUpdated?.call(textEditingController!.text);
    });

    if (widget.keyPressed != null) {
      if (widget.keyPressed!(value!)) {
        _value = '';
        textEditingController?.text = '';
      }
    }
  }

  List<Widget> _getDialerButtons(double sizeFactor) {
    var rows = <Widget>[];
    var items = <Widget>[];

    for (var i = 0; i < mainTitle.length; i++) {
      if (i % 3 == 0 && i > 0) {
        rows.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
        rows.add(SizedBox(height: sizeFactor / 6.0));
        items = <Widget>[];
      }

      items.add(DialButton(
        title: mainTitle[i],
        // subtitle: subTitle[i],
        hideSubtitle: widget.hideSubtitle!,
        color: widget.buttonColor,
        textColor: widget.buttonTextColor,
        onTap: _setText,
        sizeFactor: sizeFactor,
      ));
    }
    //To Do: Fix this workaround for last row
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      ),
    );
    rows.add(SizedBox(height: sizeFactor / 6.0));

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sizeFactor = constraints.maxHeight / 7.0;
        final sizeFactorHuge = constraints.maxHeight / 6.0;
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  readOnly: true,
                  style: TextStyle(
                    color: widget.dialOutputTextColor ?? Colors.black,
                    fontSize: sizeFactor / 2,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(border: InputBorder.none),
                  controller: textEditingController,
                ),
                ..._getDialerButtons(sizeFactor),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        widget.audioDialButtonBuilder?.call(sizeFactorHuge) ??
                            DialButton(
                              icon: widget.audioDialButtonIcon ?? Icons.phone,
                              color: widget.audioDialButtonColor != null
                                  ? widget.audioDialButtonColor!
                                  : Colors.green,
                              hideSubtitle: widget.hideSubtitle!,
                              sizeFactor: sizeFactor,
                              onTap: (value) {
                                widget.makeAudioCall!(
                                    textEditingController!.text);
                              },
                            ),
                        widget.videoDialButtonBuilder?.call(sizeFactorHuge) ??
                            DialButton(
                              icon: widget.videoDialButtonIcon ??
                                  Icons.video_call,
                              color: widget.videoDialButtonColor != null
                                  ? widget.videoDialButtonColor!
                                  : Colors.green,
                              hideSubtitle: widget.hideSubtitle!,
                              sizeFactor: sizeFactor,
                              onTap: (value) {
                                widget.makeVideoCall!(
                                    textEditingController!.text);
                              },
                            ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: sizeFactor * 0.2),
                        child: IconButton(
                          icon: Icon(
                            Icons.backspace,
                            size: sizeFactor / 2,
                            color: _value.isNotEmpty
                                ? (widget.backspaceButtonIconColor ??
                                    Colors.white24)
                                : Colors.white24,
                          ),
                          onPressed: _value.isEmpty
                              ? null
                              : () {
                                  if (_value.isNotEmpty) {
                                    setState(() {
                                      _value = _value.substring(
                                          0, _value.length - 1);

                                      textEditingController!.text = _value;
                                      widget.valueUpdated?.call(
                                        textEditingController!.text,
                                      );
                                    });
                                  }
                                },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DialButton extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final bool hideSubtitle;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final ValueSetter<String?>? onTap;
  final bool? shouldAnimate;
  final double sizeFactor;

  const DialButton({
    Key? key,
    this.title,
    this.subtitle,
    this.hideSubtitle = false,
    this.color,
    this.textColor,
    this.icon,
    this.iconColor,
    this.shouldAnimate,
    this.onTap,
    required this.sizeFactor,
  }) : super(key: key);

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _colorTween =
        ColorTween(begin: widget.color ?? Colors.white24, end: Colors.white)
            .animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    if ((widget.shouldAnimate == null || widget.shouldAnimate!) &&
        _timer != null) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(widget.title);
        }

        if (widget.shouldAnimate == null || widget.shouldAnimate!) {
          if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          } else {
            _animationController.forward();
            _timer = Timer(const Duration(milliseconds: 200), () {
              setState(() {
                _animationController.reverse();
              });
            });
          }
        }
      },
      child: ClipOval(
        child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) => Container(
            color: _colorTween.value,
            height: widget.sizeFactor,
            width: widget.sizeFactor,
            child: Center(
                child: widget.icon == null
                    ? widget.subtitle != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 8),
                              Text(
                                widget.title!,
                                style: TextStyle(
                                    fontSize: widget.sizeFactor / 2,
                                    color: widget.textColor ?? Colors.black),
                              ),
                              if (!widget.hideSubtitle)
                                Text(widget.subtitle!,
                                    style: TextStyle(
                                        color:
                                            widget.textColor ?? Colors.black))
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              widget.title!,
                              style: TextStyle(
                                  fontSize: widget.title == "*" &&
                                          widget.subtitle == null
                                      ? widget.sizeFactor
                                      : widget.sizeFactor / 2,
                                  color: widget.textColor ?? Colors.black),
                            ))
                    : Icon(widget.icon,
                        size: widget.sizeFactor / 2,
                        color: widget.iconColor ?? Colors.white)),
          ),
        ),
      ),
    );
  }
}
