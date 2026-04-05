import 'package:shared_preferences/shared_preferences.dart';

class UserSessionService {
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userRoleKey = 'user_role';

  // Save user session after login
  static Future<void> saveUserSession({
    required String userId,
    required String userName,
    required String userRole,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_userRoleKey, userRole);
  }

  // Get current user ID
  static Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Get current user role
  static Future<String?> getCurrentUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  // Get current user name
  static Future<String?> getCurrentUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Clear user session (logout)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userRoleKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final userId = await getCurrentUserId();
    return userId != null;
  }

  // For demo purposes - create a demo customer session
  static Future<void> createDemoCustomerSession() async {
    await saveUserSession(
      userId: '3abb8e05-ee7a-42b2-a826-e9f67e1d724c', // Real customer ID from database
      userName: 'Demo Customer',
      userRole: 'customer',
    );
  }

  // For demo purposes - create a demo farmer session
  static Future<void> createDemoFarmerSession() async {
    await saveUserSession(
      userId: '50a28d79-4bf3-446a-8684-32a4b8916006', // Real farmer ID from database
      userName: 'Demo Farmer',
      userRole: 'farmer',
    );
  }
}
