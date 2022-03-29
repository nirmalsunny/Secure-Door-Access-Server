<?php
ini_set('display_errors', 1); ini_set('display_startup_errors', 1); error_reporting(E_ALL); 
define('APP_VERSION', '1.0.0');

include dirname(__FILE__).'/../config.php';

include SYSTEM . '/vendor/autoload.php';
include SYSTEM . '/Bootstrap.php';
include SYSTEM . '/Routes.php';
include SYSTEM . '/Controller.php';
include SYSTEM . '/View.php';

include SYSTEM . '/Helpers.php';

if (isset($_GET['route']) && !empty($_GET['route'])) {
    $app = new App($_GET['route']);
} else {
    $app = new App("home");
}
$app->run();