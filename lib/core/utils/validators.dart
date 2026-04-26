class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email không được để trống.';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) return 'Vui lòng nhập địa chỉ email hợp lệ.';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) return 'Mật khẩu phải có ít nhất 6 ký tự.';
    return null;
  }
}