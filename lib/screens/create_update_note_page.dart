import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:notes_app/models/note_model.dart';

class CreateUpdateNotePage extends StatefulWidget {
  final NoteModel? note;
  const CreateUpdateNotePage({
    super.key,
    this.note,
  });

  @override
  State<CreateUpdateNotePage> createState() => _CreateUpdateNotePageState();
}

class _CreateUpdateNotePageState extends State<CreateUpdateNotePage> {
  final controller=Get.put(NotesController());

  @override
  void initState() {
    super.initState();
    if(widget.note!=null){
      controller.titleController.text=widget.note!.titel;
      controller.descriptionController.text=widget.note!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('${widget.note==null?'Create':'Update'} Note'),//app bar will be shown after checking that if note will create or update
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (){
                controller.createNote();
              },
              child: Icon(Icons.done, size: 30,color: Colors.black,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.titleController,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title...',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(.4),
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: controller.descriptionController,
                minLines: 40,
                maxLines: 40,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(.4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
