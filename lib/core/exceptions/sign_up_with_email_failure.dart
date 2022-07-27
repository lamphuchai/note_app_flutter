class SignUpWithEmailFailure implements Exception {
  const SignUpWithEmailFailure(
      {this.emailErr, this.passwordErr, this.otherErr});

  final String? emailErr;
  final String? passwordErr;
  final String? otherErr;

  factory SignUpWithEmailFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailFailure(emailErr: "Email không hợp lệ");
      case 'user-disabled':
        return const SignUpWithEmailFailure(otherErr: "Tài khoản đã bị khoá");
      case 'email-already-in-use':
        return const SignUpWithEmailFailure(
            emailErr: "Email đã đã được sử dụng");
      case 'operation-not-allowed':
        return const SignUpWithEmailFailure(
            otherErr:
                "Hoạt động không được phép. Vui lòng liên hệ với bộ phận hỗ trợ.");
      case 'weak-password':
        return const SignUpWithEmailFailure(
            passwordErr: "Vui lòng dùng mật khẩu mạnh hơn");
      default:
        return const SignUpWithEmailFailure();
    }
  }

  @override
  String toString() =>
      'SignUpWithEmailFailure(emailErr: $emailErr, passwordErr: $passwordErr, otherErr: $otherErr)';
}
