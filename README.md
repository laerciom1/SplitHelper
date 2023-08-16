### TODOs:

- [ ] Handle failures:
  - [ ] Handle ConfigNotifier.initializeConfig failure
  - [ ] Handle SessionNotifier.initializeSession failure
  - [ ] Handle SplitsNotifier.getSplits failure
  - [ ] Handle SplitsNotifier.save failure
  - [ ] Global Exception Catcher
- [ ] Filter Split list by Category
- [ ] Filter Split list by Date (before/after some date)
- [ ] Filter Split list by Date (specific month)
- [ ] Filter Split list by Date (specific custom interval)
- [ ] Load more button on Splits list
- [ ] Edit config (Settings page)
- [ ] Encrypt data on Firebase
- [ ] Initial settings to unregistered users (new Users)

### To generate freezed files run:
> `dart run build_runner build --delete-conflicting-outputs`