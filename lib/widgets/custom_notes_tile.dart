import 'package:flutter/material.dart';
import 'package:notes_app/controllers/notes_controller.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/create_update_note_page.dart';

class CustomNotesTile extends StatelessWidget {
  final int index;//for delete and update

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
          print(index);//just for check
          Get.to(()=> CreateUpdateNotePage(note: note,index: index,));//when we will edit
        },
        contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
        title: Text(
          note.title,
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
                    'Updated at: ${note.updatedAt!.day}/${note.updatedAt!.month}/${note.updatedAt!.year}',
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
