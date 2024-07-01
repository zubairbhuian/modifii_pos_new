class URLS {
  URLS._();
  // ***** Base URL
  static String baseURL = 'https://yogo-pos-server.vercel.app/api/v1';

  //** end popint **
  static String login = '$baseURL/server/login';
  static String categories = '$baseURL/categories';
  static String products = '$baseURL/products';
  static String placeOrder = '$baseURL/table/order/place';

  static String tableList = '$baseURL/table/dine-in-area';
  static String barList = '$baseURL/bars/list';
  static String allBarList = '$baseURL/bars/area';
  static String hallList = '$baseURL/table/hall-area';

  static String ordersList = '$baseURL/table/order/list';
  static String orderOfBookedTable(int tableId) =>
      '$baseURL/table/$tableId/current-order';   
}