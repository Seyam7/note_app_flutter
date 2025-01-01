import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_model.dart';

class NotesController extends GetxController{
  RxList<NoteModel> notes = <NoteModel>[].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void createNote(){
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
    storeData();
    update();
    titleController.clear();
    descriptionController.clear();
    Get.back();
  }

  void deleteNote(int index){
    notes.removeAt(index);
    Get.snackbar(
      'Success',
      'The note has been deleted.',
      snackPosition: SnackPosition.BOTTOM,
    );
    storeData();
  }

  void updateNote(int index){
    // Update note at the specified index
    notes[index!] = NoteModel(
      title: titleController.text,
      description: descriptionController.text,
      createdAt: notes[index!].createdAt, // Keep the original creation time
      updatedAt: DateTime.now(),
    );
    // Get.snackbar(
    //     'Success',
    //     'Note has been updated.',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    update();
    titleController.clear();
    descriptionController.clear();
    Get.back(); // Close the update screen/dialog
  }

  void storeData()async{
    var prefs = await SharedPreferences.getInstance();

    //convert list of notemodel/object to list of map
    var notesListMap = notes.map((note) {//all data of notes will be store in note variable
      return {
        'title' : note.title,
        'description' : note.description,
        'created_at' : note.createdAt.toString(),
        'update_at' : note.updatedAt.toString(),
      };
    }).toList();//toList() has been used for list off map, without it there will be store only one data
    print('map=> $notesListMap');

    //encode the list to string
    //use jsonencode for encode string from object/json data
    //use jsondecode for decode string to object/json data
    var notesListString = jsonEncode(notesListMap);
    print('string=> $notesListString');

    prefs.setString('notes', notesListString);
    print('data stored');
  }

  void loadNotes()async{
    var prefs = await SharedPreferences.getInstance();
    var noteListString = prefs.getString('notes');
    if(noteListString!=null){
      var noteListMap = jsonDecode(noteListString) as List;

      var noteListModel = noteListMap.map((note) {
        return NoteModel(
            title: note['title'],
            description: note['description'],
            createdAt: DateTime.parse(note['created_at']),
            updatedAt: note['updated-at'] == null ? null : DateTime.parse(note['updated_at']),
        );
      }).toList();
      notes.addAll(noteListModel);
      update();
      //notes.refresh();
    }

  }

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }
}