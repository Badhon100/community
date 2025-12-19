enum StorageKey {
  token,
  userEmail,
  darkMode,
  isLoggedIn,
}

extension StorageKeyExtension on StorageKey {
  String get value {
    switch (this) {
      case StorageKey.token:
        return "token";
      case StorageKey.userEmail:
        return "userEmail";
      case StorageKey.isLoggedIn:
        return "isLoggedIn";
      case StorageKey.darkMode:
        return "darkMode";
    }
  }
}
