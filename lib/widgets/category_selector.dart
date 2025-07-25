import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_border/dotted_border.dart';

class CategorySelector extends StatefulWidget {
  final Function(List<String>) onCategoriesChanged;
  const CategorySelector({super.key, required this.onCategoriesChanged});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final ScrollController _scrollController = ScrollController();
  final List<String> allCategories = ['Работа', 'Хобби', 'Учёба'];
  final List<String> selectedCategories = [];

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }

      widget.onCategoriesChanged(selectedCategories);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              
              radius: Radius.circular(24),
              dashPattern: [5, 5],
              strokeWidth: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Container(
              color: Colors.transparent,
              constraints: BoxConstraints(
              
                minWidth: double.infinity,
                minHeight: 56,
                maxHeight: 94,
                maxWidth: double.infinity,
              ),
              padding: const EdgeInsets.all(8),

              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsetsGeometry.zero,
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.minHeight,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (selectedCategories.isEmpty)
                              ...List.generate(3, (index) {
                                double width;
                                if (index == 0) {
                                  width = 60;
                                } else if (index == 1) {
                                  width = 100;
                                } else {
                                  width = 80;
                                }
                                return DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    radius: const Radius.circular(20),
                                    dashPattern: [2, 3],
                                    color: CupertinoColors.systemGrey2,
                                  ),
                                  child: Container(
                                    width: width,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                  ),
                                );
                              }),
                            ...selectedCategories.map((category) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: CupertinoColors.systemGrey2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => toggleCategory(category),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            colorFilter: ColorFilter.mode(
                                              Color.fromARGB(
                                                255,
                                                202,
                                                172,
                                                255,
                                              ),
                                              BlendMode.srcIn,
                                            ),
                                            'assets/icons/tag.svg',
                                            width: 17,
                                            height: 17,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            category,
                                            style: const TextStyle(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...allCategories.map((category) {
                return GestureDetector(
                  onTap: () => toggleCategory(category),
                  child: Container(
                    
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey2),
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(fontFamily: 'Rubik', fontSize: 14),
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () => showCreateCategoryPopup(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 202, 172, 255),
                    // border: Border.all(color: CupertinoColors.systemGrey2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        CupertinoIcons.add,
                        size: 16,
                        //color: CupertinoColors.white,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Создать',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          //color: CupertinoColors.white,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showCreateCategoryPopup(BuildContext context) {
    String newCategory = '';

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta != null && details.primaryDelta! > 2) {
              Navigator.of(context).pop(); // закрыть при свайпе вниз
            }
          },
          child: SizedBox(
            height: 500,
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),

              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Новая категория',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik',
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      placeholder: 'Введите название',
                      onChanged: (value) {
                        newCategory = value;
                      },
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          child: const Text('Отмена'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoButton.filled(
                          child: const Text('Добавить'),
                          onPressed: () {
                            if (newCategory.trim().isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                allCategories.add(newCategory.trim());
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
