class AppState {
  String firstname;
  String lastname;
  String email;
  String password;
  String message;
  String username;
  String address;
  bool loading;
  List catalogues;
  List cart;

  AppState({
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.message,
    this.username,
    this.address,
    this.loading,
    this.catalogues,
    this.cart
  });

  AppState.copyWith(AppState newState) {
    firstname = newState.firstname;
    lastname = newState.lastname;
    email = newState.email;
    password = newState.password;
    message = newState.message;
    username = newState.username;
    address = newState.address;
    loading = newState.loading;
    catalogues = newState.catalogues;
    cart = newState.cart;
  }
}