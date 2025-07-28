import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/desire_bloc.dart';
import 'package:flutter_projects/models/desire.dart';
import 'package:flutter_projects/services/desire_repository.dart';
import 'package:flutter_projects/widgets/category_selector.dart';
import 'package:flutter_projects/widgets/photo_picker.dart';

@RoutePage()
class AddDesireScreen extends StatefulWidget {
  const AddDesireScreen({super.key});

  @override
  State<AddDesireScreen> createState() => _AddDesireScreenState();
}

class _AddDesireScreenState extends State<AddDesireScreen> {
  bool _titleIsEmty = false;
  String? selectedPhoto;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          //color: const Color.fromARGB(255, 255, 76, 76),
          alignment: Alignment.bottomLeft,
          child: const Text(
            'Добавить хотелку',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          //color: const Color.fromARGB(255, 243, 243, 243),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                SizedBox(height: 5),
                AnimatedContainer(
                  width: double.infinity,
                  duration: Duration(milliseconds: 50),
                  curve: Curves.easeInExpo,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(24),
                    border: _titleIsEmty
                        ? Border.all(
                            color: Colors.red,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          )
                        : Border.all(
                            color: Colors.transparent,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                  ),
                  child: TextField(
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: titleController,

                    decoration: InputDecoration(
                      labelText: 'Название',

                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w100,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondary.withValues(alpha: 0.6),
                      ),

                      contentPadding: const EdgeInsets.all(14),

                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (_) {
                      setState(() {
                        _titleIsEmty = false;
                      });
                    },
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: TextField(
                    controller: descriptionController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'Опиши желание',

                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w100,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondary.withValues(alpha: 0.6),
                      ),
                      // чтобы placeholder был сверху при многострочном
                      contentPadding: const EdgeInsets.all(14),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),

                CategorySelector(
                  onCategoriesChanged: (newSelected) {
                    setState(() {
                      selectedCategories = newSelected;
                    });
                  },
                ),

                PhotoPicker(
                  onPhotoSelected: (file) {
                    selectedPhoto = file;
                  },
                ),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(right: 25, bottom: 25),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  _saveDesire();
                  context.read<DesireBloc>().add(LoadDesireList());
                },
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDesire() {
    if (titleController.text.isEmpty) {
      setState(() {
        _titleIsEmty = true;
      });
      return;
    }

    DesireRepository().addDesire(
      Desire(
        title: titleController.text,
        description: descriptionController.text,
        status: 'idea',
        category: selectedCategories.isEmpty ? ['Общее'] : selectedCategories,
        imageUrl: selectedPhoto,
      ),
    );
    _clearForm();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    selectedCategories.clear();
  }

  void _clearForm() {
    setState(() {
      titleController.clear();
      descriptionController.clear();
      selectedCategories.clear();
      selectedPhoto = null;
      _titleIsEmty = false;
    });
  }
}
