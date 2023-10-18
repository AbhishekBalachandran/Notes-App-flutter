import 'package:flutter/material.dart';
import 'package:notes_app/controller/notescontroller.dart';
import 'package:notes_app/utils/color-constants/color-constants.dart';
import 'package:notes_app/utils/databases/database.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  const DetailScreen({super.key, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  NotesController notesController = NotesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: notes[widget.index].color.withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: notes[widget.index].color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  notes[widget.index].title,
                  style: TextStyle(
                      color: ColorConstant.primaryTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    notes[widget.index].description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ColorConstant.primaryTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Created on : ${notes[widget.index].date.day} - ${notes[widget.index].date.month} - ${notes[widget.index].date.year}',
                  style: TextStyle(
                      color: ColorConstant.primaryTextColor,
                      fontWeight: FontWeight.w500),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Share.share(
                          '${notes[widget.index].title}\n${notes[widget.index].description}\ncreated on : ${notes[widget.index].date.day} - ${notes[widget.index].date.month} - ${notes[widget.index].date.year}');
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      color: ColorConstant.primaryTextColor,
                    )),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        notesController.deleteNote(widget.index);
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: ColorConstant.primaryTextColor,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
