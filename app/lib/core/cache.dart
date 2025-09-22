class SimpleCache<T> {
  T? _value;
  DateTime? _ts;
  final Duration ttl;
  SimpleCache({this.ttl = const Duration(seconds: 30)});

  T? get() {
    if (_value == null || _ts == null) return null;
    if (DateTime.now().difference(_ts!) > ttl) return null;
    return _value;
  }

  void set(T v) {
    _value = v;
    _ts = DateTime.now();
  }

  void clear() {
    _value = null;
    _ts = null;
  }
}
