// contact_notifier.dart
// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/apiCalls.dart';

final contactProvider = AsyncNotifierProvider<ContactNotifier, bool>(() => ContactNotifier());

class ContactNotifier extends AsyncNotifier<bool> {
  final _api = ApiCalls();

  @override
  Future<bool> build() async {
    // nothing to load initially
    return false; // initially no submission
  }

  Future<void> submitForm({
    required String name,
    required String email,
    required String message,
  }) async {
    state = const AsyncLoading(); // set loading state

    final success = await _api.submitForm(
      name: name,
      email: email,
      message: message,
    );

    if (success) {
      state = const AsyncData(true);// ✅ success
    } else {
      state = AsyncError("Failed to send message", StackTrace.current); // ❌ error
    }
  }
}
