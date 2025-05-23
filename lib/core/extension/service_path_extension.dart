import 'package:bluetrack/core/enum/service_paths_enum.dart';

extension ServicePathExtension on ServicePathsEnum {
  String get rawValue {
    switch (this) {
      // Default Paths
      case ServicePathsEnum.debugUrl:
        return 'https://bluetrack.cirkledemoapp.com/api';

      case ServicePathsEnum.relaseUrl:
        return 'https://bluetrack.cirkledemoapp.com/api';

      case ServicePathsEnum.localUrl:
        return 'https://bluetrack.cirkledemoapp.com/api';

      case ServicePathsEnum.domain:
        return 'https://bluetrack.cirkledemoapp.com/';

      case ServicePathsEnum.imagesFile:
        return 'https://cirkledemoapp.com/public/images';

      case ServicePathsEnum.getTime:
        return '/date';

      case ServicePathsEnum.getLocalization:
        return '/Lang';
      case ServicePathsEnum.getAppInformation:
        return '/app/app_info';
      case ServicePathsEnum.modifiedData:
        return '/app/get_app_updated';
      case ServicePathsEnum.login:
        return '/user/login';
      case ServicePathsEnum.signUp:
        return '/user/register';
      case ServicePathsEnum.userInfo:
        return '/user/information';
      case ServicePathsEnum.anotherProfile:
        return '/friend/index';
      case ServicePathsEnum.updateUser:
        return '/users/update';
      case ServicePathsEnum.verifyCode:
        return '/user/otp/verify';
      case ServicePathsEnum.resendVerifyCode:
        return '/user/otp/resend';

      //bluetrack
      case ServicePathsEnum.applicationData:
        return '/application-data';
      case ServicePathsEnum.changePreferredLocale:
        return '/user/change-preferred-locale';
      case ServicePathsEnum.logOut:
        return '/user/logout';
      case ServicePathsEnum.productFiltre:
        return '/products/filter';
      case ServicePathsEnum.filtreVariants:
        return '/variants/filter';

      case ServicePathsEnum.autocompleteKeys:
        return '/search/autocomplete-keys';
      case ServicePathsEnum.searchProductByTitle:
        return '/search/product';
      case ServicePathsEnum.vendorProfile:
        return '/vendor-profile';
      case ServicePathsEnum.getVendorReviews:
        return '/reviews/get-vendor-reviews';
      case ServicePathsEnum.productDetails:
        return '/product-details';
      case ServicePathsEnum.getProductReviews:
        return '/reviews/get-product-reviews';
      case ServicePathsEnum.favoritesAdd:
        return '/favorites/add';
      case ServicePathsEnum.deleteFromFavorite:
        return '/favorites/remove';
      case ServicePathsEnum.generalUserData:
        return '/general-user-data';
      case ServicePathsEnum.displayFavorite:
        return '/favorites/get-favorite-products';
      case ServicePathsEnum.unFollowVendor:
        return '/unfollow-vendor';
      case ServicePathsEnum.followVendor:
        return '/follow-vendor';
      case ServicePathsEnum.changePreferredCurrency:
        return '/user/change-preferred-currency';
      case ServicePathsEnum.activeStories:
        return '/advertisement/active-stories';
      case ServicePathsEnum.addNewAddress:
        return '/user/add-address';
      case ServicePathsEnum.updateUserAddress:
        return '/user/update-address';
      case ServicePathsEnum.getUseraddresses:
        return '/user/get-addresses';
      case ServicePathsEnum.getUseraddresses:
        return '/user/get-addresses';
      case ServicePathsEnum.addItemToCard:
        return '/cart/add-item';
      case ServicePathsEnum.updateItemQuantity:
        return '/cart/update-item-quantity';
      case ServicePathsEnum.removeItemFromCard:
        return '/cart/remove-item';
      case ServicePathsEnum.getCart:
        return '/cart/get-cart';
      case ServicePathsEnum.clearCart:
        return '/cart/clear';
      case ServicePathsEnum.createOder:
        return '/orders/store';
      case ServicePathsEnum.getUserOrders:
        return '/orders/get-user-orders';
      case ServicePathsEnum.showOrderById:
        return '/orders/show';
      case ServicePathsEnum.enableUserAds:
        return '/ads/enable-user-ads';
      case ServicePathsEnum.disableUserAds:
        return '/ads/disable-user-ads';
      case ServicePathsEnum.updateUserIdentifier:
        return '/user/update-identifier';
      case ServicePathsEnum.updateDeviceFcmToken:
        return '/user/update-fcm-token';

      default:
        return 'ERROR PATH';
    }
  }
}
