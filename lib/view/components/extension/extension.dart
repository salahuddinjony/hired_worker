extension StringCapitalization on String {
  String capitalizeFirstWord() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

extension DateTimeConverter on String {
  String getDateTime() {
    final parsed = DateTime.tryParse(this);
    if (parsed == null) return this;

    final now = DateTime.now();
    final difference = now.difference(parsed);

    if (parsed.isAfter(now)) {
      // If the date is in the future, show date, month, and year
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    } else if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}hr ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return parsed.formatDate();
    }
  }
}

extension DateFormat on DateTime {
  String formatDate() {
    final local = toLocal();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${local.day} ${months[local.month - 1]} ${local.year}';
  }
}

// Safe capitalize
extension SafeCap on String? {
  String safeCap() {
    final s = this;
    if (s == null || s.isEmpty) return '';
    if (s.length == 1) return s.toUpperCase();
    return s[0].toUpperCase() + s.substring(1, s.length).toLowerCase();
  }
}
