import 'package:hurry/core/events/note_event.dart';
import 'package:hurry/core/models/notes_model.dart';

class ContainerColorEvents extends NoteEvent {
  Note color_code;

  ContainerColorEvents(Note newColor) {
    color_code = newColor;
  }
}
