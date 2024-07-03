class DropDownOption<T> {
  const DropDownOption({
    required this.value,
    required this.option,
    this.iconPath,
  });

  final T value;
  final String option;
  final String? iconPath;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropDownOption<T> &&
        other.value == value &&
        other.option == option;
  }

  @override
  int get hashCode => value.hashCode ^ option.hashCode;
}
