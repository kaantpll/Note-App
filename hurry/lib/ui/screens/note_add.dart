import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hurry/core/blocs/bloc_note.dart';
import 'package:hurry/core/database/database_provider.dart';
import 'package:hurry/core/events/add_note.dart';
import 'package:hurry/core/events/color_container.dart';
import 'package:hurry/core/models/notes_model.dart';

class NoteAdd extends StatefulWidget {
  final Note note;
  final int note_index;

  NoteAdd({
    this.note,
    this.note_index,
  });

  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  String _title;
  String _noteText;
  static String selectedColor;
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title = widget.note.title;
      _noteText = widget.note.noteText;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                titleForm(),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: noteTextForm(),
                  height: 140,
                ),
                kaydet(),
                SizedBox(
                  height: 30.0,
                ),
                list_color(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  titleForm() {
    return TextFormField(
      initialValue: _title,
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: "Title"),
      maxLength: 30,
      onSaved: (String value) {
        _title = value;
      },
    );
  }

  noteTextForm() {
    return TextFormField(
      initialValue: _noteText,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: "Note Here"),
      maxLength: 450,
      onSaved: (String value) {
        _noteText = value;
      },
    );
  }

  kaydet() {
    return FlatButton(
      child: Text(
        "Save",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();

        Note note = Note(title: _title, noteText: _noteText);

        DatabaseProvider.db.insertNote(note).then(
            (value) => BlocProvider.of<NoteBloc>(context).add(AddNote(value)));
        Navigator.pop(context);
      },
    );
  }

  list_color() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: HexColor(colors[0]),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: HexColor(colors[1]),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: HexColor(colors[2]),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: HexColor(colors[3]),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: HexColor(colors[4]),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
