import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/note_model.dart';

class NotesController extends GetxController{
  RxList<NoteModel> notes = <NoteModel>[].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  createNote(){
    if(titleController.text.isEmpty || descriptionController.text.isEmpty){
      Get.snackbar(
          'Error',
          'All field is required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    notes.add(
        NoteModel(
            title: titleController.text,
            description: descriptionController.text,
            createdAt: DateTime.now(),
        ),
    );
    update();
    titleController.clear();
    descriptionController.clear();
    Get.back();
  }
  deleteNote(int index){
    notes.removeAt(index);
    Get.snackbar(
      'Success',
      'The note has been deleted.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  updateNote(int index){
    // Update note at the specified index
    notes[index!] = NoteModel(
      title: titleController.text,
      description: descriptionController.text,
      createdAt: notes[index!].createdAt, // Keep the original creation time
      updatedAt: DateTime.now(),
    );
    update();
    titleController.clear();
    descriptionController.clear();
    Get.back(); // Close the update screen/dialog
  }
}