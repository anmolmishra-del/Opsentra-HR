class HomeState {
  final bool isBirthday;
  final String userName;

  const HomeState({
    this.isBirthday = false,
    this.userName = '',
  });

  HomeState copyWith({
    bool? isBirthday,
    String? userName,
  }) {
    return HomeState(
      isBirthday: isBirthday ?? this.isBirthday,
      userName: userName ?? this.userName,
    );
  }
}
