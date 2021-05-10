import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/add_content_form/add_content_form_notifier.dart';
import '../application/auth/auth_notifier.dart';
import '../application/feed_page/feed_page_notifier.dart';
import '../application/map_selector/map_selector_notifier.dart';
import '../infrastructure/firestore_add_content_form_repository.dart';
import '../infrastructure/firestore_feed_page_repository.dart';
import '../infrastructure/location_package_map_selector_repository.dart';
import 'add_content_form_repository.dart';
import 'feed_page_repository.dart';
import 'map_selector_repository.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (_) => AuthNotifier(),
);

final firebaseFeedPageRepositoryProvider = Provider<FeedPageRepository>(
  (_) => FirestoreFeedPageRepository(),
);

final feedPageNotifierProvider =
    StateNotifierProvider<FeedPageNotifier, FeedPageState>(
  (ref) => FeedPageNotifier(
    ref.read(firebaseFeedPageRepositoryProvider),
  ),
);
final locationsMapSelectorRepositoryProvider = Provider<MapSelectorRepository>(
  (_) => LocationPackageMapSelectorRepository(),
);
final mapSelectorNotifierProvider =
    StateNotifierProvider<MapSelectorNotifier, MapSelectorState>(
  (ref) => MapSelectorNotifier(
    ref.read(locationsMapSelectorRepositoryProvider),
  ),
);

final firebaseInsertionRepositoryProvider = Provider<AddContentFormRepository>(
  (_) => FirestoreAddContentFormRepository(),
);
final insertionFormNotifierProvider =
    StateNotifierProvider<AddContentFormNotifier, AddContentFormState>(
  (ref) =>
      AddContentFormNotifier(ref.read(firebaseInsertionRepositoryProvider)),
);
