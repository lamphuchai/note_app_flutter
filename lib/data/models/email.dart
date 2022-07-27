import 'package:email_validator/email_validator.dart';

class Email {
  const Email({required this.value, this.errorText});
  final String value;
  final String? errorText;

  static const empty = Email(value: "");

  Email copyWith({
    String? value,
    String? errorText,
  }) {
    return Email(
      value: value ?? this.value,
      errorText: errorText ?? this.errorText,
    );
  }

  factory Email.validator(String email) {
    if (email.isEmpty) {
      return Email(value: email, errorText: "Email không thể để trống");
    } else if (!EmailValidator.validate(email)) {
      return Email(value: email, errorText: "Định dạng email không hợp lệ");
    }
    return Email(value: email);
  }

  @override
  String toString() => 'Email(email: $value, errorText: $errorText)';
}
