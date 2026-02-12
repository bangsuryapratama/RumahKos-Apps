class Api {
  // GANTI sesuai environment lo
  static const String baseUrl =
      "https://sphereless-maria-nonfibrous.ngrok-free.dev/api/tenant";
  static const String pubUrl =
      "https://sphereless-maria-nonfibrous.ngrok-free.dev/api";

  // ==================
  // AUTH
  // ==================
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String socialLogin = "$baseUrl/social-login";
  static const String logout = "$baseUrl/logout";
  static const String refreshToken = "$baseUrl/refresh-token";

  // ==================
  // PROFILE
  // ==================
  static const String profile = "$baseUrl/profile";
  static const String updateProfile = "$baseUrl/profile";
  static const String uploadDocument = "$baseUrl/profile/upload-document";
  static const String deleteDocument = "$baseUrl/profile/delete-document";

  // ==================
  // RESIDENCE (INFO KOS)
  // ==================
  static const String currentResidence = "$baseUrl/residence/current";
  static const String residenceHistory = "$baseUrl/residence/history";

  // ==================
  // ROOMS (PUBLIC)
  // ==================
  static const String roomsUrl = "$pubUrl/rooms";
  static const String availableRooms = "$roomsUrl/available/list";
  static String roomDetail(int id) => "$roomsUrl/$id";

  // ==================
  // PAYMENTS
  // ==================
  static const String paymentHistory = "$baseUrl/payments";
  static String paymentDetail(int id) => "$baseUrl/payments/$id";
  static String createSnap(int id) => "$baseUrl/payments/$id/midtrans";
  static String checkStatus(int id) => "$baseUrl/payments/$id/check-status";
}
