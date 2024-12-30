import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/create_update_note_page.dart';

class CustomNotesTile extends StatelessWidget {
  final int index;

  const CustomNotesTile({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());
    final note = controller.notes[index];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: (){
          print(index);
          Get.to(()=> CreateUpdateNotePage(note: note,));//when we will edit
        },
        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
        title: Text(
          note.titel,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black.withOpacity(.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Created at: ${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black.withOpacity(.5),
                  ),
                ),
                if(note.updatedAt!=null)
                  Text(
                    'Updated at: ${note.updatedAt!.day}/${note.updatedAt!.month}/${note.updatedAt!.year}updatedAt',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: (){
            controller.deleteNote(index);

          },
          icon: Icon(Icons.delete,color: Colors.black.withOpacity(.7),),
        ),
      ),
    );
  }
}
