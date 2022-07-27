class SignInWithEmailFailure implements Exception {
  const SignInWithEmailFailure({this.emailErr, this.passwordErr, this.otherErr});

  final String? emailErr;
  final String? passwordErr;
  final String? otherErr;

  factory SignInWithEmailFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailFailure(emailErr: "Email không hợp lệ");
      case 'user-disabled':
        return const SignInWithEmailFailure(otherErr: "Tài khoản đã bị khoá");
      case 'user-not-found':
        return const SignInWithEmailFailure(
            emailErr: "Email không có trong hệ thống");
      case 'wrong-password':
        return const SignInWithEmailFailure(passwordErr: "Mật khẩu không đúng");
      default:
        return const SignInWithEmailFailure();
    }
  }

  @override
  String toString() =>
      'SignInWithEmailFailure(emailErr: $emailErr, passwordErr: $passwordErr, otherErr: $otherErr)';
}
