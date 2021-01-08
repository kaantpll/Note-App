import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hurry/core/blocs/bloc_note.dart';

import 'package:hurry/ui/screens/note_list.dart';
import 'package:provider/provider.dart';

import 'core/models/notes_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (context) => NoteBloc(List<Note>()),
      child: MaterialApp(
        theme: ThemeData(accentColor: Colors.white),
        home: NoteList(),
      ),
    );
  }
}
