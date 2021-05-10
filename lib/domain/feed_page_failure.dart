abstract class FeedPageFailure {
  const FeedPageFailure();
  factory FeedPageFailure.serverError() = _FeedPageFailureServerError;
  factory FeedPageFailure.documentUnreachable() =
      _FeedPageFailureDocumentUnreachable;

  void when({
    required void Function(_FeedPageFailureServerError) serverError,
    required void Function(_FeedPageFailureDocumentUnreachable)
        documentUnreachable,
  }) {
    if (this is _FeedPageFailureServerError) {
      serverError.call(this as _FeedPageFailureServerError);
    }

    if (this is _FeedPageFailureDocumentUnreachable) {
      documentUnreachable.call(this as _FeedPageFailureDocumentUnreachable);
    }

    serverError.call(this as _FeedPageFailureServerError);
  }

  R map<R>({
    required R Function(_FeedPageFailureServerError) serverError,
    required R Function(_FeedPageFailureDocumentUnreachable)
        documentUnreachable,
  }) {
    if (this is _FeedPageFailureServerError) {
      return serverError.call(this as _FeedPageFailureServerError);
    }

    if (this is _FeedPageFailureDocumentUnreachable) {
      return documentUnreachable
          .call(this as _FeedPageFailureDocumentUnreachable);
    }

    return serverError.call(this as _FeedPageFailureServerError);
  }

  void maybeWhen({
    void Function(_FeedPageFailureServerError)? serverError,
    void Function(_FeedPageFailureDocumentUnreachable)? documentUnreachable,
    required void Function() orElse,
  }) {
    if (this is _FeedPageFailureServerError && serverError != null) {
      serverError.call(this as _FeedPageFailureServerError);
    }

    if (this is _FeedPageFailureDocumentUnreachable &&
        documentUnreachable != null) {
      documentUnreachable.call(this as _FeedPageFailureDocumentUnreachable);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_FeedPageFailureServerError)? serverError,
    R Function(_FeedPageFailureDocumentUnreachable)? documentUnreachable,
    required R Function() orElse,
  }) {
    if (this is _FeedPageFailureServerError && serverError != null) {
      return serverError.call(this as _FeedPageFailureServerError);
    }

    if (this is _FeedPageFailureDocumentUnreachable &&
        documentUnreachable != null) {
      return documentUnreachable
          .call(this as _FeedPageFailureDocumentUnreachable);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _FeedPageFailureServerError) {
      return 'serverError';
    }

    if (this is _FeedPageFailureDocumentUnreachable) {
      return 'documentUnreachable';
    }

    return 'serverError';
  }
}

class _FeedPageFailureServerError extends FeedPageFailure {}

class _FeedPageFailureDocumentUnreachable extends FeedPageFailure {}
