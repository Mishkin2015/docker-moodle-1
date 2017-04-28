<?php // Moodle configuration file 

unset($CFG); 
global $CFG; 

$CFG = new stdClass(); 

$CFG->dbtype = '{DB_TYPE}'; 
$CFG->dblibrary = 'native'; 
$CFG->dbhost = '{DB_HOST}'; 
$CFG->dbname = '{DB_NAME}'; 
$CFG->dbuser = '{DB_USER}'; 
$CFG->dbpass = '{DB_PASS}'; 

$CFG->prefix = 'mdl_'; 
$CFG->dboptions = array ( 
    'dbpersist' => 0, 
    'dbport' => '', 
    'dbsocket' => '', 
    'dbcollation' => 'utf8mb4_general_ci', 
);

$CFG->wwwroot = (isset($_SERVER['HTTPS']) ? 'https' : 'http') . '://' . $_SERVER['SERVER_NAME']; 
$CFG->dataroot = '/moodle/data'; 

$CFG->admin = 'admin'; 
$CFG->lang = '{MOODLE_LANG}';
$CFG->directorypermissions = 0777;

$CFG->xsendfile = 'X-Accel-Redirect';
$CFG->xsendfilealiases = array(
    '/dataroot/' => $CFG->dataroot
);

require_once(__DIR__ . '/lib/setup.php');

