<?php
//Smtp server测试

include './PHPMailer/class.phpmailer.php';

$emailObj = new PHPMailer();

//set configure options
$emailObj->SMTPSecure = 'smtp';
$emailObj->Host = 'smtp.doitphp.net';
$emailObj->Port = 25;
$emailObj->Username = 'tommy';
$emailObj->Password = '123456';
$emailObj->AddAddress('tommy@lb9558.com');
$emailObj->From = 'tommy@doitphp.net';
$emailObj->FromName = 'tommy';
$emailObj->AddReplyTo = 'tommy@doitphp.com';

$emailObj->Subject = 'Have A Nice Day';
$body = '<htm><head><title>Just for test</title></head><body>This is just a test web email</body></html>';

$emailObj->IsSMTP();
$emailObj->SMTPAuth = true;
$emailObj->CharSet ="utf-8";
$emailObj->Encoding = "base64";
$emailObj->MsgHTML($body);
$emailObj->IsHTML(true);

$result = $emailObj->Send();

var_dump($result);