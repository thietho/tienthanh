<?php
header("Location: soft/");
include('system/config/directory.php');
include('system/config/config.php');
include('system/config/startup.php');

// Front Controller
$controller = new Front();

// Router
if (isset($request->get['route'])) {
	$action = new Router($request->get['route']);
} else {
	$action = new Action('page/home', 'index');
}

// Dispatch
$controller->dispatch($action, new Action('error/not_found', 'index'));

// Output
$response->output();
?>