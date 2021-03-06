//
//  Constant.h
//  AFStore
//
//  Created by Suhas on 20/02/15.
//  Copyright (c) 2015 ___SANDS_TECHNOLOGIES___. All rights reserved.
//
#import "Utiles.h"

#define APP_NAME @"AFStore"
#define ERROR @"AFStore Error"
#define RESULT @"Result"
#define DATA @"Data"


//#define API_BASE_URL @"http://192.168.1.9/AFNew/Service1.svc/"
//#define API_BASE_URL @"http://117.218.164.150/AFNew/Service1.svc/"
//#define API_BASE_URL @"http://202.38.172.176/AFNew/Service1.svc/"


#define API_BASE_URL @"http://209.208.62.172/Afwebservices/Service1.svc/"

#define API_BASE_URL_Store @"http://209.208.62.172/AFStoreWS/Service1.svc/"

#define API_ALL_IMAGES @"http://aynalfahad.com/"

#define API_ALL_IMAGES_Store @"http://store.aynalfahad.com/"


//Home
#define API_GET_SLIDING_IMAGES (API_BASE_URL @"GetLiveRotatorSlides")
#define API_GET_SLIDING_IMAGES_HOT_DEALS (API_BASE_URL @"GetHotOffersImages")
#define API_SEARCH_PRODUCT_BY_TEXT (API_BASE_URL_Store @"GetProductListByFreeTextSearch")

#define API_GET_BANNER_IKU_IMAGES (API_BASE_URL_Store @"BannerList")


//Store
#define API_GET_BRAND_LIST (API_BASE_URL_Store @"BrandList")

#define API_GET_PRODUCT_LIST (API_BASE_URL_Store @"ProductListByBrand")
#define API_GET_PRODUCT_IMAGES (API_BASE_URL_Store @"ProductImagesByID")
#define API_GET_PRODUCT_DETAILS_BY_ID (API_BASE_URL_Store @"ProductDetailsByID")



//About Us
#define API_GET_ALL_ABOUT_US (API_BASE_URL @"GetContentsFromHtmlIOS")


//Warrantty
#define API_GET_ALL_WARRANTY (API_BASE_URL @"GetContentsFromHtmlWarranty")


#define API_GET_MAIN_CATEGORY (API_BASE_URL @"GetCategories")
#define API_GET_PRODUCT_DETAIL (API_BASE_URL @"GetProductsAllDetails")

#define API_SEND_EMAIL_FOR_PRICE (API_BASE_URL @"SendEmail")




#define API_GET_NEWS_ALL (API_BASE_URL @"GetEasyDNNNewsArchive")
#define API_GET_NEWS_DETAILS (API_BASE_URL @"GetEasyDNNNewsByArticalID")




#define API_GET_HOT_OFFER_CATEGORY_LIST (API_BASE_URL @"GetHotOfferListByCatID")
#define API_GET_HOT_OFFERS_BY_GALLERY_ID (API_BASE_URL @"GetHotOffersByGalleryID")


#define API_GET_PRODUCTS_FOR_SEARCH (API_BASE_URL @"GetProductListforSearch")



#define API_GET_GALLERY_BRANCHES (API_BASE_URL @"GetGalleryByCategoryID")
#define API_GET_GALLERY_IMAGES (API_BASE_URL @"GetHotOffersByGalleryID")

#define API_GET_GALLERY_VIDEOS (API_BASE_URL @"GetEasyGalleryVideos")
#define API_SEND_EMAIL_FOR_CONTACT_US (API_BASE_URL @"SendEmailForContactUs")


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


