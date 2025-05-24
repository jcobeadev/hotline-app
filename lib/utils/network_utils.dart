String? getNetworkIcon(String number) {
  final cleaned = number.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleaned.length < 4) return null;
  final prefix = cleaned.substring(0, 4);

  final tntPrefixes = [
    '0907', '0909', '0910', '0912', '0930', '0938', '0939',
    '0946', '0947', '0948', '0949', '0950', '0951', '0960',
    '0961', '0968', '0969', '0970', '0971', '0985', '0989',
    '0998', '0999',
  ];

  final smartPrefixes = [
    '0908', '0911', '0918', '0919', '0920', '0921', '0928',
    '0929', '0931', '0932', '0933', '0934', '0940', '0941',
    '0942', '0943', '0944', '0945', '0952', '0962', '0963',
    '0964', '0981',
  ];

  final globePrefixes = [
    '0905', '0906', '0915', '0916', '0917', '0926', '0927',
    '0935', '0936', '0937', '0945', '0953', '0954', '0955',
    '0956', '0965', '0966', '0967', '0975', '0977', '0978',
    '0979', '0994', '0995', '0996', '0997',
  ];

  final ditoPrefixes = [
    '0895', '0896', '0897', '0898', '0991', '0992', '0993',
  ];

  final gomoPrefixes = [
    '0976', '0977', '0978',
  ];

  if (tntPrefixes.contains(prefix)) return 'assets/images/networks/tnt.png';
  if (smartPrefixes.contains(prefix)) return 'assets/images/networks/smart.png';
  if (globePrefixes.contains(prefix)) return 'assets/images/networks/globe.png';
  if (ditoPrefixes.contains(prefix)) return 'assets/images/networks/dito.png';
  if (gomoPrefixes.contains(prefix)) return 'assets/images/networks/gomo.png';

  return null;
}
