import 'package:hurry/core/events/note_event.dart';
import 'package:hurry/core/models/notes_model.dart';

class AddNote extends NoteEvent {
  Note newNote;

  AddNote(Note note) {
    newNote = note;
  }
}
