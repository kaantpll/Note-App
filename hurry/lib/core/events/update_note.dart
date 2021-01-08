import 'package:hurry/core/events/note_event.dart';
import 'package:hurry/core/models/notes_model.dart';

class UpdateNote extends NoteEvent {
  int newNoteIndex;
  Note newNote;
  UpdateNote(Note note, int index) {
    newNoteIndex = index;
    newNote = note;
  }
}
