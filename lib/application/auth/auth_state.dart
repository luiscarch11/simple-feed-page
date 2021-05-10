part of 'auth_notifier.dart';

abstract class AuthState {
  const AuthState();
  factory AuthState.initial() = _AuthStateInitial;
  factory AuthState.authenticated(User user) = _AuthStateAuthenticated;

  void when({
    required void Function(_AuthStateInitial) initial,
    required void Function(_AuthStateAuthenticated) authenticated,
  }) {
    if (this is _AuthStateInitial) {
      initial.call(this as _AuthStateInitial);
    }

    if (this is _AuthStateAuthenticated) {
      authenticated.call(this as _AuthStateAuthenticated);
    }

    initial.call(this as _AuthStateInitial);
  }

  R map<R>({
    required R Function(_AuthStateInitial) initial,
    required R Function(_AuthStateAuthenticated) authenticated,
  }) {
    if (this is _AuthStateInitial) {
      return initial.call(this as _AuthStateInitial);
    }

    if (this is _AuthStateAuthenticated) {
      return authenticated.call(this as _AuthStateAuthenticated);
    }

    return initial.call(this as _AuthStateInitial);
  }

  void maybeWhen({
    void Function(_AuthStateInitial)? initial,
    void Function(_AuthStateAuthenticated)? authenticated,
    required void Function() orElse,
  }) {
    if (this is _AuthStateInitial && initial != null) {
      initial.call(this as _AuthStateInitial);
    }

    if (this is _AuthStateAuthenticated && authenticated != null) {
      authenticated.call(this as _AuthStateAuthenticated);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_AuthStateInitial)? initial,
    R Function(_AuthStateAuthenticated)? authenticated,
    required R Function() orElse,
  }) {
    if (this is _AuthStateInitial && initial != null) {
      return initial.call(this as _AuthStateInitial);
    }

    if (this is _AuthStateAuthenticated && authenticated != null) {
      return authenticated.call(this as _AuthStateAuthenticated);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _AuthStateInitial) {
      return 'initial';
    }

    if (this is _AuthStateAuthenticated) {
      return 'authenticated';
    }

    return 'initial';
  }
}

class _AuthStateInitial extends AuthState {}

class _AuthStateAuthenticated extends AuthState {
  _AuthStateAuthenticated(this.user);
  final User user;
}
