<?php
header('Content-Type: text/html;charset="UTF-8"');
if ($_GET) {
	// 关键词
	$keyword = urldecode(trim(strip_tags($_GET['keyword'])));
	if ($keyword) {
		require ( "sphinxapi.php" );

		$cl = new SphinxClient ();
		$cl->SetServer ( '127.0.0.1', 9312);
		$cl->SetConnectTimeout ( 3 );
		$cl->SetArrayResult ( true );
		$cl->SetMatchMode ( SPH_MATCH_ANY);
		$res = $cl->Query ($keyword, "*" );
		echo '<pre>';
		print_r($res);		
	}
} else {
	echo '<form method="get"><input type="type" name="keyword"><input type="submit" value="商品搜索"></form>';
}
