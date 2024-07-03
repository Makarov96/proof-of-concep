enum Routes {
  signIn(
    path: 'signIn',
  ),
  signUp(
    path: 'signUp',
  ),
  home(path: 'home'),
  splash(path: '/');

  const Routes({required this.path});
  final String path;
}
