import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/models/desire.dart';
import 'package:flutter_svg/svg.dart';

class CardOfDesire extends StatefulWidget {
  final Desire desire;

  const CardOfDesire({super.key, required this.desire});

  @override
  State<CardOfDesire> createState() => _CardOfDesireState();
}

class _CardOfDesireState extends State<CardOfDesire> {
  double _scale = 1.0;

  void _showCardMenu(
    BuildContext context,
    LongPressStartDetails details,
    Desire desire,
  ) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      color: Colors.grey,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 150),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        overlay.size.width - details.globalPosition.dx,
        overlay.size.height - details.globalPosition.dy,
      ),
      constraints: BoxConstraints(maxWidth: 180),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 202, 172, 255),
                  BlendMode.srcIn,
                ),
                'assets/icons/edit.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 8),
              Text(
                textAlign: TextAlign.end,
                'Редактировать',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 202, 172, 255),
                  BlendMode.srcIn,
                ),
                'assets/icons/Delete Icon.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 8),
              Text(
                textAlign: TextAlign.end,
                'Удалить',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((_) {
      setState(() {
        _scale = 1.0; // Возвращаем масштаб после закрытия меню
      });
      print(desire.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: (details) async {
            setState(() => _scale = 0.97); // Уменьшаем карточку
            await Future.delayed(const Duration(milliseconds: 80));

            if (mounted) {
              // ignore: use_build_context_synchronously
              _showCardMenu(context, details, widget.desire);
              HapticFeedback.lightImpact();
            }
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 50,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.desire.title,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Описание
                          Text(
                            widget.desire.description,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.desire.imageUrl != null &&
                        widget.desire.imageUrl!.isNotEmpty)
                      Photo(widget.desire.imageUrl).buildWidget(),
                  ],
                ),
                SizedBox(height: 24, width: double.infinity),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 8,
                        children: [
                          ...widget.desire.category.cast<String>().map<Widget>((
                            cat,
                          ) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Photo {
  String? imgUrl;

  Photo(this.imgUrl);

  Widget buildWidget() {
    if (imgUrl != null && imgUrl!.isNotEmpty) {
      return SizedBox(
        height: 80,
        width: 80,
        child: Container(
          decoration: BoxDecoration(
            //border: Border.all(),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(imgUrl!),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                //errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 80,
        width: 80,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            //color: const Color.fromARGB(221, 255, 208, 208),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.photo,
                  size: 40,
                  color: CupertinoColors.inactiveGray,
                ),

                //SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ); // или какой-то другой placeholder
    }
  }
}
