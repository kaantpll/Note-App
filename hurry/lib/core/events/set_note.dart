import 'package:hurry/core/events/note_event.dart';
import 'package:hurry/core/models/notes_model.dart';

class SetNote extends NoteEvent {
  List<Note> newNoteList;

  SetNote(List<Note> list) {
    newNoteList = list;
  }
}
