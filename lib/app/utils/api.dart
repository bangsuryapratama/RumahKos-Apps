class Api {
  // GANTI sesuai environment lo
  static const String baseUrl = "https://sphereless-maria-nonfibrous.ngrok-free.dev/api/tenant";

  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String socialLogin = "$baseUrl/social-login";
  static const String logout = "$baseUrl/logout";
  static const String profile = "$baseUrl/profile";
  static const String updateProfile = "$baseUrl/update-profile";
  static const String refreshToken = "$baseUrl/refresh-token";
}
