import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_in_play_proof/widgets/dropwon/dropwon_option.dart';

class JustPlayDropDown<T> extends StatelessWidget {
  const JustPlayDropDown({
    super.key,
    required this.onSelect,
    required this.label,
    this.options = const [],
    this.value,
    this.helperText,
    this.hintText,
    this.width = 395,
    this.hasRequired = true,
    this.iconSize,
    this.icon,
  });
  final List<DropDownOption<T>> options;
  final T? value;
  final String label;
  final String? hintText;
  final String? helperText;
  final bool hasRequired;
  final Function(T?) onSelect;
  final double width;
  final Widget? icon;
  final Size? iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(3),
      width: 500,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30)),
      child: DropdownButtonHideUnderline(
        child: DropdownMenu<T>(
          width: 350,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          initialSelection: value,
          trailingIcon: icon,
          label: Text(label),
          hintText: hintText,
          helperText: helperText,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            helperStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
            labelStyle: MaterialStateTextStyle.resolveWith(
              (states) {
                return const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                );
              },
            ),
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (states) {
                if (states.contains(
                  MaterialState.error,
                )) {
                  return const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  );
                } else if (states.contains(
                  MaterialState.focused,
                )) {
                  return const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  );
                }
                return TextStyle(
                  fontSize: 16,
                  color: value == null ? Colors.grey.shade500 : Colors.black,
                );
              },
            ),
            alignLabelWithHint: true,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
          ),
          dropdownMenuEntries: List.generate(
            options.length,
            (index) {
              return DropdownMenuEntry<T>(
                value: options[index].value,
                label: options[index].option,
                leadingIcon: options[index].iconPath == null
                    ? null
                    : SvgPicture.network(
                        options[index].iconPath!,
                      ),
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith(
                    (states) => const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
          onSelected: onSelect,
        ),
      ),
    );
  }
}
