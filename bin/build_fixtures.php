<?php
$ts = time();
$publicKey = '<INSERT MARVEL PUBLIC KEY>';
$privateKey = '<INSERT MARVEL PRIVATE KEY>';

$params = ['apikey' => $publicKey, 'ts' => $ts, 'hash' => md5($ts.$privateKey.$publicKey)];
$url = 'http://gateway.marvel.com/v1/public/characters?'.http_build_query($params);
$content = file_get_contents($url);
$characters = array_map(function ($character) {
	$row = ['name' => $character['name'], 'uri' => $character['resourceURI']];
	if ($character['thumbnail']) {
		$row['thumbnail'] = sprintf('%s.%s', $character['thumbnail']['path'], $character['thumbnail']['extension']);
	}

	return $row;
}, json_decode($content, true)['data']['results']);

$handle = fopen(__DIR__.'/../ReactiveCSVParserTests/Fixtures/characters.csv', 'w+');

foreach ($characters as $character) {
	fputcsv($handle, $character);
}

fclose($handle);
