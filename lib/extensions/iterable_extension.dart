extension IterableExtension<T> on Iterable<T> {
  T? findBy(bool Function(T) test) {
    for (final item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }
}
