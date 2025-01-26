part of 'red_envelope.dart';

enum DemoCustomMessageType {
  redEnvelope,
}

ButtonStyle sendRedEnvelopeButtonStyle() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.redAccent),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    shape: WidgetStateProperty.all(
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ),
  );
}
