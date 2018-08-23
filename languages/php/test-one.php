<?php
if(count($argv) < 2){
    echo "Usage: ". $argv[0]." <inputfile>\n";
    die();
}

require 'vendor/autoload.php';

$my_file = $argv[1];
$handle = fopen($my_file, 'r');
$data = fread($handle,filesize($my_file));
fclose($handle);

$output = Mf2\parse($data, 'http://example.com/');

echo( json_encode($output) . "\n");
