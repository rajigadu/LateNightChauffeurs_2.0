//
//  LncUserConstants .swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

let kApptitle = "Late Night Chauffeurs"
class I18n  {
   
static let NoInterNetString                           = "No Internet,Please Check"
static let ModelDecodeErrorString                     = "Error: Trying to parse Employees to model"
static let GetRequestFailedString                     = "Error: Employees GET Request failed"
static let GOOGLE_PLACE_FILTER_KEY                    = "AIzaSyBRzUCMhC0dooTNbHeIpD2iycfIawOHM6g"

static let alertTitle                                 = "Late Night Chauffeurs"
static let allFieldsEmpty                             = "All fields are mandatory!"
static let registeredEmail                            = "Please Enter your Registered Email!"
static let networkError                               = "There is no internet connection for this device"
static let validEmailID                               = "Enter a valid email id."
static let servernotResponding                        = "Server not responding. Please try again!!"
static let LoginStatus                                = "please login your account?"
static let EnterComments                              = "Please enter your comments"
static let CurrentZipCode                             = "Please enable your Current Zip Code"
static let passwordCheck                              = "password and confirm passowrd not matching"
static let passwordcharacters                         = "password must include 6 Characters"
static let passwordRequiredChar                       = "password should be atleast one number and one capital letter"
static let LogoutAlert                                = "Are you sure you want to logout?"
static let ServerLoading                              = "Loading..."
static let EmaildPasswordValid                        = "Email & password Should mandatory"
static let EmaildValid                                = "Please Enter Your EmailID"
static let ValidPickUpDrop                            = "Please Enter Both PickUp & Drop Locations to continue"
static let CreditCardCheck                            = "Please choose a credit card to continue"
static let Droplatitude                               = "Please Enter Correct Drop Location to continue"
static let DropAndPicklatitude                        = "Unable To Found Address "
static let Pickuplatitude                             = "Please Enter Correct Pickup Location to continue"
static let NextRideRemainTime                          = "Please select Next Ride Remain Time"
static let CheckingValidPickUpDrop                    = "Please Enter Both  PickUp & Drop valid Locations to continue"
static let GOOGLEMAPS_KEY                             = "AIzaSyDqJTzOGiWP4_1eedeVgfMUJV5thablGck"
static let Googlemaps_key                             = "google-api-key.php"
static let kGeoCodingString                           = "https://maps.google.com/maps/geo?q=%f,%f&output=csv"
}

class API_URl  {
//AIzaSyBDybITlSnO_Im4sa0ykNi-euAc1Srrxaw
//#define GOOGLEMAPS_KEY                             = "AIzaSyDqJTzOGiWP4_1eedeVgfMUJV5thablGck""AIzaSyDac9yBJCmt8Tyry6JJ6GOvNQPx0_j76-o"
//#define GOOGLEADSKEY_URL                           = "ca-app-pub-4390509928498561/9249929325"
//#define API_SERVER_URL                             = "https://www.latenightchauffeurs.com/lnc-administrator/ios/"
static let API_SERVER_URL                             = "https://lnc.latenightchauffeurs.com/lnc-administrator/ios/"
static let API_SERVER_URL2                            = "https://lnc.latenightchauffeurs.com/lnc-administrator/ios/"
//#define API_SERVER_URL2                            = "https://www.latenightchauffeurs.com/lnc-administrator/ios/"
//#define API_BASEIMAGE_URL                          = "https://www.latenightchauffeurs.com/lnc-administrator/uploads/"
//#define API_BANNERIMAGEBASE_URL                    = "https://www.latenightchauffeurs.com/lnc-administrator/admin/images/"
static let API_BASEIMAGE_URL                          = "https://lnc.latenightchauffeurs.com/lnc-administrator/uploads/"
static let API_BANNERIMAGEBASE_URL                    = "https://lnc.latenightchauffeurs.com/lnc-administrator/admin/images/"

static let API_GoogleEstimatedistancepriceapi         = "https://maps.googleapis.com/maps/api/distancematrix/json?"
//
static let  API_LOGIN_URL                              = API_URl.API_SERVER_URL + "login.php?"
static let  API_REGISTRATION_URL                       = API_URl.API_SERVER_URL + "signup.php?"
static let  API_FORGETPASSWORD_URL                     = API_URl.API_SERVER_URL + "reset-password.php?"
static let  API_CHANGEPASSWORD_URL                     = API_URl.API_SERVER_URL + "change-password.php?"
static let  API_UPDATEPROFILE_URL                      = API_URl.API_SERVER_URL + "edit-profile.php?"
static let  API_HELP_URL                               = API_URl.API_SERVER_URL + "help.php"
static let  API_CONTACTUS_URL                          = API_URl.API_SERVER_URL + "contact-us.php?"
static let  API_LOGOUT_URL                             = API_URl.API_SERVER_URL + "logout.php?"
static let  API_FACEBOOKEMAILCHECKING_URL              = API_URl.API_SERVER_URL + "facebook_status.php?"
static let  API_SOCIALLOGIN_URL                        = API_URl.API_SERVER_URL + "social-signup.php?"
static let  API_SOCIALLOGINSTATUS_URL                  = API_URl.API_SERVER_URL + "social-status.php?"
static let  API_PRIVACYPOLICY_URL                      = API_URl.API_SERVER_URL + "privay-policy.php"
static let  API_TERMSCONDITIONS_URL                    = API_URl.API_SERVER_URL + "terms.php"
static let  API_ADDADDRESS_URL                         = API_URl.API_SERVER_URL + "add-address.php?"
static let  API_ADDRESSLIST_URL                        = API_URl.API_SERVER_URL + "get-drop-location.php?"
static let  API_REMOVEADDRESS_URL                      = API_URl.API_SERVER_URL + "delete.php?"
static let  API_EDITADDRESS_URL                        = API_URl.API_SERVER_URL + "edit_user_address.php?"
static let  API_ESTIMATEDPRICE_URL                     = API_URl.API_SERVER_URL + "estimate-price.php?"
static let  API_CURRENTRIDESTOPLIST_URL                = API_URl.API_SERVER_URL + "num-stops-addres-list.php?"
static let  API_FEEDBACK_URL                           = API_URl.API_SERVER_URL + "driver-rating.php?"

//NORMAL PROCESS API'S....
static let API_LOCATIONLIST_URL                        = API_URl.API_SERVER_URL + "location.php"
static let API_USERRIDEREQUEST_URL                     = API_URl.API_SERVER_URL + "booking-reservation.php"  // = "booking-reservation.php"
static let API_EDITUSERRIDEREQUEST_URL                 = API_URl.API_SERVER_URL + "edit-ride.php?"
static let API_USERRIDELIST_URL                        = API_URl.API_SERVER_URL + "payment-history-complete-cancel.php?"// = "ride-history.php?"
static let API_USERFUTURERIDEHISTORY_URL               = API_URl.API_SERVER_URL + "future-ride-history.php?"
static let API_USERPAYMENTSUMMARY_URL                  = API_URl.API_SERVER_URL + "payment-details.php?"
static let API_USERPAYMENTHISTORY_URL                  = API_URl.API_SERVER_URL + "payment-details.php?"
static let API_USERFUTURECANCELRIDE_URL                = API_URl.API_SERVER_URL + "cancel-future-ride.php?"
static let API_USERFUTURERIDEDETAILS_URL               = API_URl.API_SERVER_URL + "future_ride_driver_detail.php?"
static let API_USERFUTURERIDELIST_URL                  = API_URl.API_SERVER_URL + "future_ride_list.php?"
static let API_USERDERVICETOKEN_URL                    = API_URl.API_SERVER_URL + "update-device-token.php?"
static let API_USERRIDEDETAILS_URL                     = API_URl.API_SERVER_URL + "user-current-ride-detail.php?"
static let API_USERSAVEDLOCATIONLIST_URL               = API_URl.API_SERVER_URL + "get-user-location.php?"
static let API_ADDCREDITCARD_URL                       = API_URl.API_SERVER_URL + "add-cc-card.php?"    //= "add-card.php?"
static let API_CARDCONNECT_ADDCARD_URL                 = API_URl.API_SERVER_URL + "cc-add-card.php?"
static let API_USERSAVEDCREDITCARDLIST_URL             = API_URl.API_SERVER_URL + "card-list.php?"
static let API_REMOVESAVEDUSERCREDITCARD_URL           = API_URl.API_SERVER_URL + "remove-card.php?"
static let API_REVIEWRATINGTODRIVER_URL                = API_URl.API_SERVER_URL + "driver-rating.php?"
static let API_USER_CURRENTRIDEDETAILS_URL             = API_URl.API_SERVER_URL + "user-current-ride.php?"
static let API_USER_UPDATESELECTEDLOCATION_URL         = API_URl.API_SERVER_URL + "update-user-location-info.php?"
static let API_USER_CHATWITHDRIVER_URL                 = API_URl.API_SERVER_URL + "chat.php?"
static let API_BANNERADS_URL                           = API_URl.API_SERVER_URL + "banner_api.php?"
static let API_DRIVERLOCATONGETTING_URL                = API_URl.API_SERVER_URL + "get-driver-location.php?"
static let API_CANCELRIDE_URL                          = API_URl.API_SERVER_URL + "cancel-ride.php?"
static let API_ONGOING_REQUESTSRIDE                    = API_URl.API_SERVER_URL + "auto-cancel.php?"//ongoing-request-remove.php
static let API_PROMOTIONSLIST_URL                      = API_URl.API_SERVER_URL + "offer-messages.php?"
static let API_CURRENTFUTURERIDE_URL                   = API_URl.API_SERVER_URL + "ride-info.php?"
static let API_CANCELRIDEAMOUNT_URL                    = API_URl.API_SERVER_URL + "cancel-ride-amount.php?"
static let API_Promocode_URL                           = API_URl.API_SERVER_URL + "promo-check.php?"
static let API_IS_EDITABLE_RIDEINFO_URL                = API_URl.API_SERVER_URL + "edit-ride-difference.php?"
static let API_RichNotification_url                    = API_URl.API_SERVER_URL + "notification-message-list.php?"
//https://www.latenightchauffeurs.com/lnc-administrator/ios/edit-ride-difference.php?ride_id=5621  http://lnc.latenightchauffeurs.com/lnc-administrator/ios/notification-message-list.php
}
