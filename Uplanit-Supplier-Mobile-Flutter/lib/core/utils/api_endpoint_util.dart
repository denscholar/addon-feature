class ApiEndpoint {
  //ONBOARDING
  static const String CATEGORIES = "/public/category";
  static const String EVENT_TYPES = "/vendor/open/event_types";

  static const String CHECK_ONBOARD = "/vendor/onboard";

  static const String CREATE_PROFILE = "/vendor/onboard/profile";
  static const String CREATE_CATEGORY = "/vendor/onboard/categories";
  static const String CREATE_EVENT_TYPE = "/vendor/onboard/event_types";

  static const String GET_SUPPLIER_CATEGORIES = "/public/category";
  static const String GET_EVENT_TYPES = "/vendor/open/event_types";

  //BUSINESS PROFILE ENDPOINTS
  static const String GET_BASE_PROFILE = "/vendor/profile";
  static const String UPDATE_BASE_PROFILE = "/vendor/profile?section=profile";
  static const String UPDATE_SUPPLIER_CATEGORIES =
      "/vendor/profile?section=categories";
  static const String UPDATE_EVENT_TYPES =
      "/vendor/profile?section=event_types";
  static const String CREATE_PROFILE_ADDRESS = "/vendor/profile/address";
  static const String UPDATE_PROFILE_ADDRESS =
      "/vendor/profile?section=address";
  static const String CREATE_CONTACT = "/vendor/profile/contact";
  static const String UPDATE_CONTACT = "/vendor/profile?section=contact";

  static const String GET_COUNTRIES = "/vendor/open/countries";
  static const String GET_WORK_DAYS = "/vendor/open/days";
  static const String UPDATE_WORK_HOURS = "/vendor/profile?section=work_time";
//Business Info
  static const String GET_BUSINESS_INFO = "/vendor/account/payment";
  static const String CREATE_UPDATE_BUSINESS_INFO = "/vendor/account/payment";
  //Utilities
  static const String GET_FILE_UPLOAD_URL = "/vendor/assets/uploadurl";
  // static const String UPLOAD_FILE_TO_S3 =
  //     "https://uplanit-test.s3-accelerate.amazonaws.com/o74Nnfo5wUhRq8ULa3psmMNtaW23/assets/95ecc380-afe9-11e4-9b6c-751b66dd541e.png?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARYJI6LY4BJ23NZ4W%2F20201027%2Feu-west-2%2Fs3%2Faws4_request&X-Amz-Date=20201027T140054Z&X-Amz-Expires=360000&X-Amz-Signature=3b630f3ef69fab8b8405a3c52d360e25298a064ea9a1765a4afc9b5614bb3a81&X-Amz-SignedHeaders=host";
  static const String UPDATE_COVER_IMAGE = "/vendor/profile?section=cover";
  static const String UPDATE_LOGO_IMAGE = "/vendor/profile?section=logo";
  //Portfolio
  static const String ADD_IMAGE = "/vendor/portfolio/images";
  static const String GET_IMAGES = "/vendor/portfolio/images";
  static const String DELETE_IMAGE = "/vendor/portfolio/images";

  //Payment Provider
  static const String ADD_STRIPE =
      "/vendor/account/payment/stripe/:code?state=k204E8qjzD";
  static const String GET_STRIPE_DETAIL = "/vendor/account/payment/stripe";
  static const String DELETE_STRIPE_CONNECT = "/vendor/account/payment/stripe";
  //Payment Plan
  static const String GET_ALL_PAYMENT_PLAN = "/vendor/payment_plan";
  static const String GET_ONE_PAYMENT_PLAN = "/vendor/payment_plan/one/";
  static const String ACTIVATE_PAYMENT_PLAN = "/vendor/payment_plan/activate/";
  static const String DEACTIVE_PAYMENT_PLAN =
      "/vendor/payment_plan/deactivate/";
  static const String CREATE_NEW_PAYMENT_PLAN = "/vendor/payment_plan";
  //Team
  static const String GET_TEAM = "/vendor/providers";
  static const String GET_TEAM_MEMBER_BY_ID = "/vendor/providers/one/";
  static const String UPDATE_TEAM_MEMBER_DETAIL = "/vendor/providers/update/";
  static const String CREATE_TEAM_MEMBER = "/vendor/providers";
  static const String UPDATE_PROVIDER_IMAGE = "/vendor/providers/update-image/";
  static const String MARK_MONTH_AS_AVAILABLE_FOR_TEAM_MEMBER =
      "/vendor/providers/availability/fill/";
  static const String SET_TEAM_MEMBER_DAY_AS_UNAVAILABLE =
      "/vendor/providers/availability/unset/";
  static const String SET_TEAM_MEMBER_DAY_AS_AVAILABLE =
      "/vendor/providers/availability/fillday/";
  //Calendar
  static const String GET_CALENDAR = '/vendor/calendar';
  static const String MARK_DAY_AS_AVAILABLE = '/vendor/calendar/fillday/';
  static const String UNSET_DAY_AVAILABILITY = '/vendor/calendar/unset/';
  static const String MARK_AS_BUSY = '/vendor/calendar/mark_as_busy';
  static const String REMOVE_BUSY_TIME = '/vendor/calendar/calendar_events/';
  //Services
  static const String GET_SERVICES = "/vendor/services";
  static const String CREATE_SERVICE = "/vendor/services/create";
  static const String UPDATE_SERVICE = "/vendor/services/update/:service_id";
  static const String ADD_SERVICE_IMAGE = "/vendor/services/images/:service_id";
  static const String DELETE_SERVICE_IMAGE =
      "/vendor/services/images/:service_id"; //PATCH METHOD
  //---ADDONS
  static const String CREATE_ADDON = "/vendor/services/add-ons/create";
  static const String GET_ADDONS = "/vendor/services/add-ons";
  static const String GET_ONE_ADDON = "/vendor/services/add-ons/one/:_id";
  static const String DELETE_ADDON_IMAGE =
      "/vendor/services/add-ons/images/:addon_id"; //PATCH
  static const String ADD_ADDON_IMAGE =
      "/vendor/services/add-ons/images/:addon_id";
  static const String UPDATE_ADDON =
      "/vendor/services/add-ons/update/:addon_id";
  //currencies
  static const String GET_ALL_CURRENCIES = "/vendor/open/currency";
  static const String GET_MY_CURRENCY = "/vendor/currency";
  static const String SET_TRADING_CURRENCY = "/vendor/currency";
}
