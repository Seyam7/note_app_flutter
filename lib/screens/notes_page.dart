import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:notes_app/screens/create_update_note_page.dart';
import 'package:notes_app/widgets/custom_notes_tile.dart';
import 'package:get/get.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Colors.yellow[600],
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Obx((){
        if(controller.notes.isEmpty){
          return Center(
            child: Text('No notes!'),
          );
        }
        else{
          return ListView.separated(
            //reverse: true,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return CustomNotesTile(
                index: index,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: controller.notes.length,
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => CreateUpdateNotePage());
        },
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }
}
