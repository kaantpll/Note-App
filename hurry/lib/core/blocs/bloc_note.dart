import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hurry/core/events/add_note.dart';
import 'package:hurry/core/events/color_container.dart';
import 'package:hurry/core/events/note_event.dart';
import 'package:hurry/core/events/remove_note.dart';
import 'package:hurry/core/events/set_note.dart';
import 'package:hurry/core/events/update_note.dart';
import 'package:hurry/core/models/notes_model.dart';

class NoteBloc extends Bloc<NoteEvent, List<Note>> {
  NoteBloc(List<Note> initialState) : super(initialState);

  @override
  Stream<List<Note>> mapEventToState(NoteEvent event) async* {
    if (event is AddNote) {
      List<Note> newStateList = List.from(state);
      if (newStateList != null) {
        newStateList.add(event.newNote);
      }
      yield newStateList;
    } else if (event is RemoveNote) {
      List<Note> newStateList = List.from(state);
      newStateList.removeAt(event.newIndex);
      yield newStateList;
    } else if (event is SetNote) {
      yield event.newNoteList;
    } else if (event is UpdateNote) {
      List<Note> newStateList = List.from(state);
      newStateList[event.newNoteIndex] = event.newNote;
      yield newStateList;
    }
  }
}
