abstract class AddContentFormFailure {
  const AddContentFormFailure();
  factory AddContentFormFailure.serverError() =
      _AddContentFormFailureServerError;

  void when({
    required void Function(_AddContentFormFailureServerError) serverError,
  }) {
    if (this is _AddContentFormFailureServerError) {
      serverError.call(this as _AddContentFormFailureServerError);
    }

    serverError.call(this as _AddContentFormFailureServerError);
  }

  R map<R>({
    required R Function(_AddContentFormFailureServerError) serverError,
  }) {
    if (this is _AddContentFormFailureServerError) {
      return serverError.call(this as _AddContentFormFailureServerError);
    }

    return serverError.call(this as _AddContentFormFailureServerError);
  }

  void maybeWhen({
    void Function(_AddContentFormFailureServerError)? serverError,
    required void Function() orElse,
  }) {
    if (this is _AddContentFormFailureServerError && serverError != null) {
      serverError.call(this as _AddContentFormFailureServerError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_AddContentFormFailureServerError)? serverError,
    required R Function() orElse,
  }) {
    if (this is _AddContentFormFailureServerError && serverError != null) {
      return serverError.call(this as _AddContentFormFailureServerError);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _AddContentFormFailureServerError) {
      return 'serverError';
    }

    return 'serverError';
  }
}

class _AddContentFormFailureServerError extends AddContentFormFailure {}
