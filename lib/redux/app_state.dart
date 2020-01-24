class AppState {
  String email;
  String password;
  String message;
  bool loading;

  AppState({
    this.email,
    this.password,
    this.message,
    this.loading
  });

  AppState.copyWith(AppState newState) {
    email = newState.email;
    password = newState.password;
    message = newState.message;
    loading = newState.loading;
  }
}