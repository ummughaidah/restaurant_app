enum NavigationRoute {
  restaurantRoute("/restaurant"),
  detailRoute("/detail"),
  searchRoute("/search"),
  homeRoute("/home"),
  favoriteRoute("/favorite"),
  settingRoute("/setting");

  const NavigationRoute(this.route);
  final String route;
}
