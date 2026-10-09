class AuthUser {
  final String username;
  final String name;
  final String email;
  final String phone;

  const AuthUser({
    required this.username,
    required this.name,
    required this.email,
    this.phone = '',
  });
}

class AuthService {
  AuthService._();

  static final List<_Account> _accounts = [
    const _Account(
      password: 'ecowalk123',
      user: AuthUser(
        username: 'linda',
        name: 'Ade Linda Febriana',
        email: 'adelindafebriana15@gmail.com',
      ),
    ),
  ];

  static Future<AuthUser?> login(String identifier, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final input = identifier.trim().toLowerCase();
    for (final acc in _accounts) {
      final match =
          acc.user.username == input || acc.user.email.toLowerCase() == input;
      if (match && acc.password == password) return acc.user;
    }
    return null;
  }

  static Future<String?> register({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final u = username.trim().toLowerCase();
    final e = email.trim().toLowerCase();

    if (_accounts.any((a) => a.user.username == u)) {
      return 'Nama pengguna sudah dipakai';
    }
    if (_accounts.any((a) => a.user.email.toLowerCase() == e)) {
      return 'Email sudah terdaftar';
    }

    _accounts.add(
      _Account(
        password: password,
        user: AuthUser(
          username: u,
          name: username.trim(),
          email: e,
          phone: phone.trim(),
        ),
      ),
    );
    return null;
  }
}

class _Account {
  final String password;
  final AuthUser user;

  const _Account({required this.password, required this.user});
}
