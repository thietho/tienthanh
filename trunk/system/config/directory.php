<?php
// HTTP
define('HTTP_IMAGE', 'http://localhost:81/tienthanh/file/');
define('HTTP_SERVER', 'http://localhost:81/tienthanh/');

// HTTPS
define('HTTPS_SERVER', '');
define('HTTPS_IMAGE', '');

// DIR
define('DIR_APPLICATION', '');
define('DIR_CONTROLLER','controller/');
define('DIR_MODEL','model/');
define('DIR_LANGUAGE', 'language/');

define('DIR_DATABASE', 'system/database/');
define('DIR_COMPONENT', 'component/');
define('DIR_FILE','file/');
define('DIR_SYSTEM', 'system/');
define('DIR_CACHE', 'file/cache/');
define('DIR_CACHEHTML', 'file/cachehtml/');

$filename = DIR_FILE."db/setting.json";;
@$handle = fopen($filename, "r");
@$contents = fread($handle, filesize($filename));
@fclose($handle);
$setting = json_decode($contents);

if($setting->skin=="")
$setting->skin="skin1";

define('DIR_VIEW','view/'.$setting->skin.'/');
define('DIR_TEMPLATE','view/'.$setting->skin.'/template/');
define('DIR_IMAGE', 'view/'.$setting->skin.'/image/');
define('DIR_FLASH', 'view/'.$setting->skin.'/flash/');
define('DIR_CSS', 'view/'.$setting->skin.'/css/');
define('DIR_JS', 'view/'.$setting->skin.'/js/');
define('DIR_XML', 'view/'.$setting->skin.'/xml/');

?>