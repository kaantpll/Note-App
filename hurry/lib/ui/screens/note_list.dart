import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hurry/core/blocs/bloc_note.dart';
import 'package:hurry/core/database/database_provider.dart';
import 'package:hurry/core/events/remove_note.dart';
import 'package:hurry/core/events/set_note.dart';
import 'package:hurry/core/models/notes_model.dart';
import 'package:hurry/ui/screens/note_add.dart';
import 'package:hexcolor/hexcolor.dart';

class NoteList extends StatefulWidget {
  NoteList({Key key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getNotes().then(
        (value) => BlocProvider.of<NoteBloc>(context).add(SetNote(value)));

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: BlocConsumer<NoteBloc, List<Note>>(
          builder: (context, noteList) {
            return PageView.builder(
              controller: _pageController,
              itemCount: noteList.length,
              itemBuilder: (BuildContext context, int index) {
                return _selector(index, noteList);
              },
            );
          },
          listener: (BuildContext context, noteList) {},
        ),
      ),
      floatingActionButton: _floatingBtn(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FloatingActionButton _floatingBtn(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (conteext) => NoteAdd(),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("Hurry", style: TextStyle(color: Colors.blue, fontSize: 32)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
    );
  }

  Widget _selector(int index, List<Note> noteList) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 600.0,
            width: Curves.easeInOut.transform(value) * 600.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white, width: 3),
                    color: HexColor("#8456AD").withAlpha(200),
                    /*boxShadow: [
                      BoxShadow(
                        color: HexColor("#FEF579").withAlpha(200),
                        offset: Offset(0.0, 2.0),
                        //blurRadius: 1.0,
                      ),
                    ],*/
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 40,
                                width: 300,
                                child: Text(
                                  noteList[index].title,
                                  style: TextStyle(
                                      fontSize: 32, color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 50),
                              SingleChildScrollView(
                                child: Container(
                                  width: 300,
                                  height: 360,
                                  child: Text(
                                    noteList[index].noteText,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 30,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Note note = Note();
                                      DatabaseProvider.db
                                          .delete(note.id)
                                          .then((value) => {
                                                BlocProvider.of<NoteBloc>(
                                                        context)
                                                    .add(
                                                  RemoveNote(index),
                                                ),
                                              });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.person_pin_circle,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.person_pin_circle,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
