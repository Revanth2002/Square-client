/*List of all IP Adddresses and end points */

const String PROTOCOL = "http";
const String PORT = "8000";
// const String DOMAIN = "192.168.1.7"; // acer
const String DOMAIN = "192.168.1.8";  // lenovo
const String BASE_URL = "$PROTOCOL://$DOMAIN:$PORT/api/v1";


/*-------Auth API ------- */
const String LOGIN_URL = "$BASE_URL/login/";
const String REGISTER_URL = "$BASE_URL/register/";
const String VERIFY_OTP_URL = "$BASE_URL/verify/";


