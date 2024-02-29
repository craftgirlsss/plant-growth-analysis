String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Pagi';
  }
  if (hour < 17) {
    return 'Siang';
  }
  return 'Malam';
}