class AppStrings {
  AppStrings._();

  static const appName = 'Responsive Forge';
  static const appTagline = 'Generate Flutter responsive extensions instantly';

  static const generatorTab = 'Generator';
  static const calculatorTab = 'Calculator';

  static const generate = 'Generate Extension';
  static const copyCode = 'Copy Code';
  static const downloadFile = 'Download .dart';
  static const copied = 'Copied!';

  static const noPreview = 'Fill in the form and tap\nGenerate Extension';
  static const calcDesc = 'Test values across different screen sizes';

  static const platforms = ['Mobile', 'Tablet', 'Web', 'All'];

  static const presetScreens = <String, List<double>>{
    'iPhone SE': [375, 667],
    'iPhone 14': [390, 844],
    'iPhone 14 Pro Max': [430, 932],
    'Pixel 7': [412, 915],
    'Samsung S23': [360, 780],
    'iPad Air': [820, 1180],
    'iPad Pro 12.9"': [1024, 1366],
    'Web HD': [1280, 720],
    'Web FHD': [1920, 1080],
  };
}
