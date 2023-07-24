abstract class PickerOption<T> {
  String get title;

  T get value;
}

class StringPickerOption extends PickerOption<String> {
  StringPickerOption(this._value);

  final String _value;

  @override
  String get title => _value;

  @override
  String get value => _value;
}
