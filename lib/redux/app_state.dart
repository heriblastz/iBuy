class AppState {
  String email;
  String password;
  String message;

  AppState({
    this.email,
    this.password,
    this.message
  });

  AppState.copyWith(AppState newState) {
    email = newState.email;
    password = newState.password;
    message = newState.message;
  }
}