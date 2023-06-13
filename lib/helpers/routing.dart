/*List of all IP Adddresses and end points */

// const String PROTOCOL = "https";
const String PROTOCOL = "http";
const String PORT = "8000";
// const String DOMAIN = "192.168.1.7"; // acer
// const String DOMAIN = "pangea-server.vercel.app";  // lenovo
const String DOMAIN = "165.22.209.61:8000";  // lenovo
const String BASE_URL = "$PROTOCOL://$DOMAIN/api/v1";


/*-------Auth API ------- */
const String LOGIN_URL = "$BASE_URL/login/";
const String REGISTER_URL = "$BASE_URL/register/";
const String VERIFY_OTP_URL = "$BASE_URL/verify/";

/*------Home API ------- */
const String HOME_URL = "$BASE_URL/home-screen/";
const String GET_CARDS_URL = "$BASE_URL/get-cards/";
const String MY_PROFILE_URL = "$BASE_URL/myprofile/";
const String ALL_TRANSACTIONS_URL = "$BASE_URL/all-transactions/";
const String NOTIFICATIONS_URL = "$BASE_URL/notification/";
const String TRANSACTION_PEOPLE = "$BASE_URL/transaction-people/";

/*------Setup API ------- */
const String SETUP_PIN_URL = "$BASE_URL/setup-pin/";
const String ADD_CARD_URL = "$BASE_URL/add-card/";
const String UPDATE_CARD_URL = "$BASE_URL/update-cards/";

/*------Payment API------*/
const String SEND_MONEY_URL = "$BASE_URL/send-money/";
const String SCAN_QR_CHECKER = "$BASE_URL/scan-qr/";

/*------Search API------*/
const String SEARCH_URL = "$BASE_URL/search/";

const String CHECK_BALANCE_URL = "$BASE_URL/check-balance/";

