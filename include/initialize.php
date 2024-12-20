<?php
// Define core paths
// Define them as absolute paths to ensure require_once works correctly

// DIRECTORY_SEPARATOR is a PHP predefined constant (\ for Windows, / for Unix)
defined('DS') ? null : define('DS', DIRECTORY_SEPARATOR);

// Define the root directory dynamically
defined('SITE_ROOT') ? null : define('SITE_ROOT', __DIR__);

// Define the library path correctly
defined('LIB_PATH') ? null : define('LIB_PATH', SITE_ROOT);

// Load the database configuration and other required files
require_once __DIR__ . '/config.php';
require_once(LIB_PATH.DS."function.php");
require_once(LIB_PATH.DS."session.php");
require_once(LIB_PATH.DS."accounts.php");
require_once(LIB_PATH.DS."autonumbers.php");
require_once(LIB_PATH.DS."companies.php");
require_once(LIB_PATH.DS."job.php");
require_once(LIB_PATH.DS."employees.php");
require_once(LIB_PATH.DS."categories.php");
require_once(LIB_PATH.DS."applicant.php");
require_once(LIB_PATH.DS."jobregistration.php");
require_once(LIB_PATH.DS."database.php");
?>
