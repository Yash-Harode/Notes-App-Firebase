import 'package:flutter/material.dart';
import 'package:codeland/database/database_handler.dart';
import 'package:codeland/models/note_model.dart';
import 'package:codeland/theme/colors.dart';
import 'package:codeland/utils/utility.dart';
import 'package:codeland/widgets/button_widget.dart';
import 'package:codeland/widgets/form_widget.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool _isNoteCreating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  int selectedColor = 4294967295;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _isNoteCreating == true ? lightGreyColor : darkBackgroundColor,
      body: AbsorbPointer(
        absorbing: _isNoteCreating,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _isNoteCreating == true
                ? Image.asset(
                    "assets/ios_loading.gif",
                    width: 50,
                    height: 50,
                  )
                : Container(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      ButtonWidget(icon: Icons.done, onTap: _createNote),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormWidget(
                    fontSize: 40,
                    controller: _titleController,
                    hintText: "Title",
                  ),
                  const SizedBox(height: 10),
                  FormWidget(
                    maxLines: 15,
                    fontSize: 20,
                    controller: _bodyController,
                    hintText: "Start typing...",
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      itemCount: predefinedColors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final singleColor = predefinedColors[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = singleColor.value;
                            });
                          },
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 60,
                            decoration: BoxDecoration(
                                color: singleColor,
                                border: Border.all(
                                    width: 3,
                                    color: selectedColor == singleColor.value
                                        ? Colors.white
                                        : Colors.transparent),
                                shape: BoxShape.circle),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createNote() {
    setState(() => _isNoteCreating = true);
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      if (_titleController.text.isEmpty) {
        toast(message: 'Enter Title');
        setState(() => _isNoteCreating = false);
        return;
      }
      if (_bodyController.text.isEmpty) {
        toast(message: 'Type something in the body');
        setState(() => _isNoteCreating = false);
        return;
      }
      DatabaseHandler.createNote(NoteModel(
              title: _titleController.text,
              body: _bodyController.text,
              color: selectedColor))
          .then((value) {
        _isNoteCreating = false;
        Navigator.pop(context);
      });
    });
  }
}
