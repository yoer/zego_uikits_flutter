// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';
import 'defines.dart';

class GiftsSheet extends StatefulWidget {
  final List<GiftModel> gifts;
  final void Function(GiftModel)? onSend;

  const GiftsSheet({
    super.key,
    required this.gifts,
    required this.onSend,
  });

  @override
  State<GiftsSheet> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsSheet> {
  final selectedTabNotifier = ValueNotifier<int>(0);
  final selectedGiftNotifier = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final giftsByCategory = groupGiftsByCategory(widget.gifts);

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          tabBar(giftsByCategory.keys.toList()),
          SizedBox(height: 20.r),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedTabNotifier,
              builder: (context, selectedIndex, _) {
                return table(
                  giftsByCategory[
                      giftsByCategory.keys.toList()[selectedIndex]]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBar(List<int> types) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: types.map((type) {
          return GestureDetector(
            onTap: () {
              selectedTabNotifier.value = types.indexOf(type);
              selectedGiftNotifier.value = -1;
            },
            child: ValueListenableBuilder(
              valueListenable: selectedTabNotifier,
              builder: (context, selectedIndex, _) {
                return Container(
                  height: 60.r,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selectedIndex == types.indexOf(type)
                            ? Colors.yellow
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.r,
                    vertical: 8.r,
                  ),
                  child: Text(
                    GiftCategoryExtension.fromInt(type).name,
                    style: TextStyle(
                      color: selectedIndex == types.indexOf(type)
                          ? Colors.yellow
                          : Colors.grey,
                      fontSize: 30.r,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget table(List<GiftModel> gifts) {
    const columnCount = 4;
    final rowCount = (gifts.length + 3) ~/ columnCount;
    final itemWidth = MediaQuery.sizeOf(context).width / columnCount;

    return SingleChildScrollView(
      child: Column(
        children: List.generate(rowCount, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              columnCount,
              (columnIndex) {
                final index = rowIndex * columnCount + columnIndex;
                if (index < gifts.length) {
                  final gift = gifts[index];
                  return GestureDetector(
                    onTap: () {
                      selectedGiftNotifier.value = gift.id;
                    },
                    child: giftItem(gift, itemWidth),
                  );
                } else {
                  return Expanded(child: Container());
                }
              },
            ),
          );
        }),
      ),
    );
  }

  Widget giftItem(GiftModel gift, double itemWidth) {
    final iconWidth = itemWidth * 0.6;
    final fontSize = (itemWidth - iconWidth - 10.r) * 0.3;
    return ValueListenableBuilder(
      valueListenable: selectedGiftNotifier,
      builder: (context, selectedGiftID, _) {
        final bool isSelected = selectedGiftID == gift.id;

        return Container(
          width: itemWidth,
          height: itemWidth,
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  color: Colors.white.withOpacity(0.3),
                )
              : null,
          child: isSelected
              ? selectedGiftItem(
                  gift: gift,
                  itemWidth: itemWidth,
                  iconWidth: iconWidth,
                  fontSize: fontSize,
                  buttonHeight: itemWidth -
                      fontSize -
                      iconWidth -

                      /// font
                      10.r

                      /// border
                      -
                      2 * 1.r,
                )
              : normalGiftItem(
                  gift: gift,
                  iconWidth: iconWidth,
                  fontSize: fontSize,
                ),
        );
      },
    );
  }

  Widget selectedGiftItem({
    required GiftModel gift,
    required double itemWidth,
    required double iconWidth,
    required double fontSize,
    required double buttonHeight,
  }) {
    return Column(
      children: [
        SizedBox(
          width: iconWidth,

          /// border
          height: iconWidth,
          child: Lottie.asset(gift.type.asset),
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: null == widget.onSend
              ? null
              : () {
                  widget.onSend?.call(gift);
                },
          child: Container(
            width: itemWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            child: Text(
              Translations.gift.give,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget normalGiftItem({
    required GiftModel gift,
    required double iconWidth,
    required double fontSize,
  }) {
    return Column(
      children: [
        Container(
          width: iconWidth,
          height: iconWidth,
          margin: EdgeInsets.only(bottom: 10.r),
          child: Lottie.asset(gift.type.asset, animate: false),
        ),
        Text(
          gift.type.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  Map<int, List<GiftModel>> groupGiftsByCategory(List<GiftModel> gifts) {
    final giftsByType = <int, List<GiftModel>>{};
    for (final gift in gifts) {
      if (!giftsByType.containsKey(gift.category.index)) {
        giftsByType[gift.category.index] = [];
      }
      giftsByType[gift.category.index]!.add(gift);
    }
    return giftsByType;
  }
}
