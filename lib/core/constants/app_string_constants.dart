

class AppConstants {
  // Auth const
  static const hasLogin = 'has_login';
  static const hasOpened = 'has_opened';
  static const keepLogin = 'keep_login';
  static const isLoggedIn = 'is_logged_in';
  static const accessToken = 'access_token';
  static const userId = 'user_id';
  static const username = 'username';
  static const email = 'email';
  static const refreshToken = 'refresh_token';
  static const incompleteRegistration = 'INCOMPLETE_REGISTRATION';
  static const nairaSymbol = '\u20A6';

  static const productList = [
    'https://static.vecteezy.com/system/resources/thumbnails/034/629/691/small_2x/chic-blue-sofa-with-tufted-backrest-and-plush-cushions-stylishly-perched'
        '-on-slender-wooden-legs-on-transparent-background-cut-out-furniture-front-view-ai-generated-png.png',
    'https://pngimg.com/uploads/refrigerator/refrigerator_PNG101553.png',
    'https://www.pngarts.com/files/5/Split-Air-Conditioner-PNG-Free-Download.png',
    'https://purepng.com/public/uploads/large/purepng.com-front-loading-washing-machineelectronicswashing-machine-941524677853qd3um.png',
    'https://purepng.com/public/uploads/thumbnail/purepng.com-audio-speakeraudio-speakersaudiospeakerssound-speaker-17015283435358wdcw.png'
  ];

  static const List<Map<String, dynamic>> productsWithPrice = [
    {
      'imageUrl': 'https://static.vecteezy.com/system/resources/thumbnails/034/629/691/small_2x/chic-blue-sofa-with-tufted-backrest-and-plush-cushions-stylishly-perched'
          '-on-slender-wooden-legs-on-transparent-background-cut-out-furniture-front-view-ai-generated-png.png',
      'productName': 'HeatWave HeatWave ComfortMax 300',
      'price': 120000,
      'oldPrice': 210000,
      'percentageOff': 30,
    },
    {
      'imageUrl': 'https://pngimg.com/uploads/refrigerator/refrigerator_PNG101553.png',
      'productName': 'HeatWave HeatWave ComfortMax 300',
      'price': 120000,
      'oldPrice': 210000,
    },
    {
      'imageUrl':'https://www.pngarts.com/files/5/Split-Air-Conditioner-PNG-Free-Download.png',
      'productName': 'HeatWave HeatWave ComfortMax 300',
      'price': 120000,
      'oldPrice': 210000,
      'percentageOff': 15,
    },


    {
      'imageUrl':'https://purepng.com/public/uploads/large/purepng.com-front-loading-washing-machineelectronicswashing-machine-941524677853qd3um.png',
      'productName': 'HeatWave HeatWave ComfortMax 300',
      'price': 120000,
      'oldPrice': 210000,
    },
    {
      'imageUrl':'https://purepng.com/public/uploads/thumbnail/purepng.com-audio-speakeraudio-speakersaudiospeakerssound-speaker-17015283435358wdcw.png',
      'productName': 'HeatWave HeatWave ComfortMax 300',
      'price': 120000,
      'oldPrice': 210000,
      'percentageOff': 22,
    },
    // Add more products here
  ];
}
