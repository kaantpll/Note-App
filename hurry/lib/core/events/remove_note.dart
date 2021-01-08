import 'package:hurry/core/events/note_event.dart';

class RemoveNote extends NoteEvent {
  int newIndex;

  RemoveNote(int index) {
    newIndex = index;
  }
}
