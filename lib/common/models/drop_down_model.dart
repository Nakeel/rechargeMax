class DropDownOption {
  final String label;
  final String value;
  final String? imgPath, desc;

  const DropDownOption({
    required this.label,
    required this.value,
    this.imgPath, this.desc,
  });

  @override
  String toString() {
    return label ;
  }
}