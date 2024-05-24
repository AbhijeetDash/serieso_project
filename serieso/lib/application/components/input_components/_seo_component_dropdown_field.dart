import 'package:flutter/material.dart';
import 'package:serieso/application/constants/_seo_const_brandcolors.dart';

class SeoComponentDropdownField<T> extends StatefulWidget {
  final String? initialValue;
  final List<T> dropdownItems;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final String hintText;
  final bool isOnDark;

  const SeoComponentDropdownField({
    Key? key,
    this.initialValue,
    this.isOnDark = true,
    required this.onChanged,
    required this.dropdownItems,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  State<SeoComponentDropdownField<T>> createState() =>
      _SeoComponentDropdownFieldState<T>();
}

class _SeoComponentDropdownFieldState<T>
    extends State<SeoComponentDropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<T>(
          hint: Text(
            widget.hintText,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          decoration: const InputDecoration(border: InputBorder.none),
          dropdownColor: widget.isOnDark
              ? BrandColors.colorShadowLightOnDark
              : BrandColors.colorShadowDarkOnLight,
          items: widget.dropdownItems
              .map((T value) => DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      (value as Enum).name,
                      style: TextStyle(
                          fontSize: 16,
                          color: widget.isOnDark
                              ? BrandColors.textLight
                              : BrandColors.textDark),
                    ),
                  ))
              .toList(),
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ),
    );
  }
}
