import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/controller/notescontroller.dart';
import 'package:notes_app/model/models.dart';
import 'package:notes_app/utils/color-constants/color-constants.dart';
import 'package:notes_app/utils/databases/database.dart';
import 'package:notes_app/utils/image_constants/image_constants.dart';
import 'package:notes_app/view/detail-screen/detail-screen.dart';
import 'package:share_plus/share_plus.dart';

class NoteListScreen extends StatefulWidget {
  NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  NotesController notesController = NotesController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Color? selectedColor;
  int? selectedColorIndex = 0;

  DateTime selectedDate = DateTime.now();

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    setState(() {
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
      }
    });
  }

  @override
  void initState() {
    selectedColorIndex = 0;
    selectedColor = color[selectedColorIndex!];
    loadDbData();
    super.initState();
  }

  Future<void> loadDbData() async {
    final noteList = await notesController.loadData();
    setState(() {
      notes = noteList;
    });
  }

  void clearFun() {
    titleController.text = '';
    descriptionController.text = '';
    selectedColorIndex = 0;
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
          backgroundColor: ColorConstant.backgroundColor,
          elevation: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConstants.notesIcon),
                  ),
                ),
              ),
            ],
          ),
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Take',
                  style: GoogleFonts.zeyada(
                    fontSize: 30,
                      color: Colors.white, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'NOTE',
                  style: GoogleFonts.exo(
                    fontSize: 25,
                      color: Colors.amber, fontWeight: FontWeight.w600))
            ]),
          )),
      // floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // bottom sheet
          showModalBottomSheet(
            backgroundColor: ColorConstant.backgroundColor,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                clearFun();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: ColorConstant.primaryTextColor,
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstant.textfieldBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: titleController,
                              style: TextStyle(
                                  color: ColorConstant.primaryTextColor),
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: ' Title',
                                hintStyle: TextStyle(
                                    color: ColorConstant.primaryTextColor,
                                    fontSize: 20),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstant.textfieldBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: descriptionController,
                              style: TextStyle(
                                  color: ColorConstant.primaryTextColor),
                              autofocus: true,
                              minLines: 5,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(
                                    color: ColorConstant.primaryTextColor,
                                    fontSize: 20),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstant.textfieldBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: dateController,
                              style: TextStyle(
                                  color: ColorConstant.primaryTextColor),
                              autofocus: true,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: ColorConstant.primaryTextColor,
                                  ),
                                ),
                                hintText:
                                    '${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',
                                hintStyle: TextStyle(
                                    color: ColorConstant.primaryTextColor,
                                    fontSize: 20),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Choose color',
                        style: TextStyle(color: ColorConstant.primaryTextColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: color.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedColor = color[index];
                                  selectedColorIndex = index;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: color[index],
                                    borderRadius: BorderRadius.circular(10)),
                                child: selectedColorIndex == index
                                    ? Center(child: Icon(Icons.check))
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ElevatedButton(
                                    onPressed: () {
                                      clearFun();
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: ColorConstant.primaryTextColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        notesController.addNote(NoteModel(
                                            title: titleController.text,
                                            description:
                                                descriptionController.text,
                                            date: selectedDate,
                                            color: selectedColor!));
                                      });
                                      clearFun();
                                      Navigator.pop(context);
                                      const snackBar = SnackBar(
                                        content: Text(
                                          'Note added successfully.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.amberAccent,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                        color: ColorConstant.primaryTextColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ))),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(index: index),
                  ));
            },
            child: Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                  color: notes[index].color,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                notes[index].title,
                                style: TextStyle(
                                    color: ColorConstant.primaryTextColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  notes[index].description,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: ColorConstant.primaryTextColor,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Share.share(
                                        '${notes[index].title}\n${notes[index].description}\ncreated on : ${notes[index].date.day} - ${notes[index].date.month} - ${notes[index].date.year}');
                                  },
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: ColorConstant.primaryTextColor,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      notesController.deleteNote(index);
                                    });
                                    const snackBar = SnackBar(
                                      content: Text(
                                        'Note deleted successfully.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.amberAccent,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: ColorConstant.primaryTextColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Created on : ${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',
                          style: TextStyle(
                              color: Color.fromARGB(255, 207, 207, 207),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
