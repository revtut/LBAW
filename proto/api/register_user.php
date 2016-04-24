<?php 
include_once('../config/init.php');
include_once($BASE_DIR.'database/users.php');

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'No permission to access this page!';
    http_response_code(404);
    return;
}

// Check permission to access the page
$user = get_user_by_name($_SESSION['username']);
if ($user.role !== 'Administrador') {
    $_SESSION['error_messages'][] = 'No permission to access this page!';
    http_response_code(404);
    return;
}

// Role
if (!isset($_POST['role'])) {
    $_SESSION['error_messages'][] = 'Parameters are missing!';
    http_response_code(404);
    return;
}
$role = $_POST['role'];

// Check if all parameters exist
$params = array('id', 'email', 'password', 'name', 'gender', 'birth');
if ($role === 'Amigo') array_push($params, 'nif', 'cellphone', 'donative_type', 'periodicity');

foreach($params as $param) {
    if (!isset($_POST[$param])) {
        $_SESSION['error_messages'][] = 'Parameters are missing!';
        http_response_code(404);
        return;
    } else {
        $params[$param] = $_POST[$param];
    }
}

// Validate input parameters
if (!filter_var($params['email'], FILTER_VALIDATE_EMAIL)) {
    $_SESSION['error_messages'][] = 'Invalid input emails!';
    http_response_code(404);
    return;
}

// Insert in the database
if ($role === 'Amigo') {
    $result = register_friend(
    $params['id'],
    $params['email'],
    sha1($params['password']),
    $params['name'],
    $params['gender'],
    $params['birth'],
    $params['nif'],
    $params['cellphone'],
    $params['donative_type'],
    $params['periodicity'],
    $params['donative_amount']);
} else {
    $result = register_user(
    $params['id'],
    $params['role'],
    $params['email'],
    sha1($params['password']),
    $params['name'],
    $params['gender'],
    $params['birth']);
}

// Return result
if ($result) {
    $_SESSION['success_messages'][] = 'Registered successfully!';
    http_response_code(200);
    return;
} else {
    $_SESSION['error_messages'][] = 'Error while registering in the database!';
    http_response_code(404);
    return;
}

?>