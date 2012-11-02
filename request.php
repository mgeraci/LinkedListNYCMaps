<?php
  $key = 'AIzaSyAa5R9714gGFc7NOFFuIeFmFTM11Z-CW2s';
  $location = $_GET['location'];
  $radius = $_GET['radius'];
  $types = $_GET['types'];
  $name = $_GET['name'];
  echo file_get_contents("https://maps.googleapis.com/maps/api/place/search/json?location=$location&radius=$radius&types=$types&name=$name&sensor=false&key=$key");
?>
