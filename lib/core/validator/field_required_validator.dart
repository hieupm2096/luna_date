import 'package:form_field_validator/form_field_validator.dart';

class FieldRequiredValidator<T> extends FieldValidator<T> {
  FieldRequiredValidator(super.errorText);

  @override
  bool isValid(T? value) {
    return value != null;
  }
}
