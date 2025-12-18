enum StorageKey {
  authToken,
  userId,
  isLoggedIn,
  themeMode,
}

extension StorageKeyX on StorageKey {
  String get value => name;
}
