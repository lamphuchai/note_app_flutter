class Password {
  const Password({required this.value, this.errorText});
  final String value;
  final String? errorText;

  static const empty = Password(value: "");

  Password copyWith({
    String? value,
    String? errorText,
  }) {
    return Password(
      value: value ?? this.value,
      errorText: errorText ?? this.errorText,
    );
  }

  factory Password.validator(String text) {
    if (text.isEmpty) {
      return Password(value: text, errorText: "Mật khẩu không thể để trống");
    } else if (text.length < 6) {
      return Password(
          value: text, errorText: "Mật khẩu phải có ít nhất 6 ký tự");
    }
    return Password(value: text);
  }
}
