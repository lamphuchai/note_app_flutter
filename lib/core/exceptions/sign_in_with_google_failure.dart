class SignInWithGoogleFailure implements Exception {
  final String message;

  const SignInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const SignInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const SignInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const SignInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SignInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SignInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const SignInWithGoogleFailure();
    }
  }
}
