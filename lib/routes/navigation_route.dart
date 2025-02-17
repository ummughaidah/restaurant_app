enum NavigationRoute {
  restaurantRoute("/restaurant"),
  detailRoute("/detail"),
  searchRoute("/search");

  const NavigationRoute(this.route);
  final String route;
}
