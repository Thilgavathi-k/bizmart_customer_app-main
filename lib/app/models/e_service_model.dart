


import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'category_model.dart';
import 'e_provider_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class EService extends Model {
  String id;
  String name;
  String company_name;
  String district;
  String description;
  List<Media> images;
  double price;
  double discountPrice;
  String priceUnit;
  String quantityUnit;
  double rate;
  int totalReviews;
  String duration;
  bool featured;
  bool enableBooking;
  bool isFavorite;
  List<Category> categories;
  List<Category> subCategories;
  EProvider eProvider;
  VideoPlayerController videoPlayerController;
  bool startedPlaying = false;
  String assets = 'assets/img/sample_960x540.3gp';
  String cat_id;
  String serviceImage;
  String address;
  String city;
  String pincode;
  String landmark;
  String mobile_number;
  String registered_with_gstn;
  //+++++++++++++businesss details+++++++++++++++++++++++++++++
  String bussiness_website;
  String add_certificate;
  String add_awards;
  String video;
  String add_your_establishment;
  //+++++++++++++++++Social media links++++++++++++++++++++++++++++
  String facebook_link;
  String instagram_link;
  String twitter_link;
  String youtube_link;
  String linkedin_link;
  String yahoo;

  bool isDownload;

  EService(
      {this.id,
      this.name,
      this.company_name,
      this.district,
      this.description,
      this.images,
      this.price,
        this.discountPrice,
      this.priceUnit,
      this.quantityUnit,
      this.rate,
      this.totalReviews,
      this.duration,
      this.featured,
      this.enableBooking,
      this.isFavorite,
      this.categories,
      this.subCategories,
      this.eProvider,
      this.videoPlayerController,
        this.startedPlaying,
        this.assets,
        this.cat_id,
        this.serviceImage,
        this.address,
        this.city,
        this.pincode,
        this.landmark,
        this.mobile_number,
        this.registered_with_gstn,
        this.isDownload,



      });

  EService.fromJson(Map<String, dynamic> json) {
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    district = transStringFromJson(json, 'district');
    address = transStringFromJson(json, 'address');
    city = transStringFromJson(json, 'city');
    pincode = transStringFromJson(json, 'pincode');
    landmark = transStringFromJson(json, 'landmark');
    mobile_number = transStringFromJson(json, 'mobile_number');
    company_name = transStringFromJson(json, 'company_name');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    priceUnit = stringFromJson(json, 'price_unit');
    quantityUnit = transStringFromJson(json, 'quantity_unit');
    rate = doubleFromJson(json, 'rate');
    totalReviews = intFromJson(json, 'total_reviews');
    duration = stringFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    enableBooking = boolFromJson(json, 'enable_booking');
    isFavorite = boolFromJson(json, 'is_favorite');
    isDownload = boolFromJson(json, 'isDownload');
    categories = listFromJson<Category>(json, 'categories', (value) => Category.fromJson(value));
    subCategories = listFromJson<Category>(json, 'sub_categories', (value) => Category.fromJson(value));
    eProvider = objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
    cat_id= transStringFromJson(json, 'cat_id');
    serviceImage = transStringFromJson(json, 'image');

    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (name != null) data['name'] = this.name;

    if (this.description != null) data['description'] = this.description;
    if (this.district != null) data['district'] = this.district;
    if (this.landmark != null) data['landmark'] = this.landmark;
    if (this.pincode != null) data['pincode'] = this.pincode;
    if (this.address != null) data['address'] = this.address;
    if (this.city != null) data['city'] = this.city;
    if (this.mobile_number != null) data['mobile_number'] = this.mobile_number;
    if (this.company_name != null) data['company_name'] = this.company_name;
    if (this.price != null) data['price'] = this.price;
    if (discountPrice != null) data['discount_price'] = this.discountPrice;
    if (priceUnit != null) data['price_unit'] = this.priceUnit;
    if (quantityUnit != null && quantityUnit != 'null') data['quantity_unit'] = this.quantityUnit;
    if (rate != null) data['rate'] = this.rate;
    if (totalReviews != null) data['total_reviews'] = this.totalReviews;
    if (duration != null) data['duration'] = this.duration;
    if (featured != null) data['featured'] = this.featured;
    if (enableBooking != null) data['enable_booking'] = this.enableBooking;
    if (isFavorite != null) data['is_favorite'] = this.isFavorite;
    if (isDownload != null) data['isDownload'] = this.isDownload;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v?.id).toList();
    }
    if (this.images != null) {
      data['image'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.subCategories != null) {
      data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    }
    if (this.eProvider != null && this.eProvider.hasData) {
      data['e_provider_id'] = this.eProvider.id;
    }
    if (cat_id != null) data['cat_id'] = this.cat_id;
    if (serviceImage != null) data['iamge'] = this.serviceImage;
    if (company_name != null) data['company_name'] = this.company_name;
    if (address != null) data['address'] = this.address;
    if (city != null) data['city'] = this.city;
    if (district != null) data['district'] = this.district;
    if (mobile_number != null) data['mobile_number'] = this.mobile_number;
    return data;
  }

  String get firstImageUrl => this.images?.first?.url ?? '';

  String get firstImageThumb => this.images?.first?.thumb ?? '';

  String get firstImageIcon => this.images?.first?.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }

  String get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit.isNotEmpty) {
        return "/" + quantityUnit.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is EService &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          district == other.district &&
          company_name == other.company_name &&
          description == other.description &&
          rate == other.rate &&
          isFavorite == other.isFavorite &&
          isDownload == other.isDownload &&
          enableBooking == other.enableBooking &&
          categories == other.categories &&
          subCategories == other.subCategories &&
          eProvider == other.eProvider && videoPlayerController == other.videoPlayerController&&
          startedPlaying==other.startedPlaying&&assets == assets&&
          cat_id == other.cat_id &&
          address == other.address &&
          pincode == other.pincode &&
          landmark == other.landmark &&
          mobile_number == other.mobile_number &&
          city == other.city &&
          serviceImage == other.serviceImage;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      district.hashCode ^
      company_name.hashCode ^
      rate.hashCode ^
      eProvider.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      address.hashCode ^
      landmark.hashCode ^
      pincode.hashCode ^
      mobile_number.hashCode ^
      city.hashCode ^

      isFavorite.hashCode ^
      isDownload.hashCode ^
      enableBooking.hashCode ^ videoPlayerController.hashCode^startedPlaying.hashCode^assets.hashCode^
      cat_id.hashCode ^
      serviceImage.hashCode;
}
