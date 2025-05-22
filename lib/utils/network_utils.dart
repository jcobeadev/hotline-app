String? getNetworkIcon(String number) {
  final prefix = number.replaceAll(RegExp(r'[^0-9]'), '').substring(0, 4);

  final smartPrefixes = [
    '0907', '0908', '0918', '0919', '0920', '0921', '0928', '0929',
    '0930', '0938', '0939', '0946', '0947', '0948', '0949', '0950',
    '0951', '0961', '0963', '0968', '0969', '0970', '0981', '0989',
    '0998', '0999',
  ];

  final globePrefixes = [
    '0905', '0906', '0915', '0916', '0917', '0926', '0927', '0935',
    '0936', '0937', '0945', '0953', '0954', '0955', '0956', '0965',
    '0966', '0967', '0975', '0977', '0978', '0979', '0994', '0995',
    '0996', '0997',
  ];

  if (smartPrefixes.contains(prefix)) {
    return 'assets/images/networks/smart.png';
  }

  if (globePrefixes.contains(prefix)) {
    return 'assets/images/networks/globe.png';
  }

  return null;
}
