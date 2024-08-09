class URLS {
  URLS._();
  // ***** Base URL
  static String baseURL = 'https://yogo-pos.vercel.app/api/v1';

  //** end popint **
  static String login = '$baseURL/auth/login';
  static String employeeLogin = '$baseURL/employees/login';
  static String employees = '$baseURL/employees';
  static String clockIn = '$baseURL/clocks/clock-in';
  static String clockOut = '$baseURL/clocks/clock-out';
  static String categories = '$baseURL/categories';
  static String mainCategories = '$baseURL/main-categories';
  static String orderStatus = '$baseURL/orders/order-status';
  static String orders = '$baseURL/orders';

  static String products = '$baseURL/products';
  static String placeOrder = '$baseURL/orders/place-order';

  static String tableCategory = '$baseURL/table-categories';
  static String tableHold = '$baseURL/tables';
  static String barList = '$baseURL/bars/list';
  static String allBarList = '$baseURL/bars/area';
  static String hallList = '$baseURL/table/hall-area';

  static String ordersList = '$baseURL/table/order/list';
  static String orderOfBookedTable(int tableId) =>
      '$baseURL/table/$tableId/current-order';
}
