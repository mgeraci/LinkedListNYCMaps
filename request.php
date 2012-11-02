<?php
  $key = 'AIzaSyAa5R9714gGFc7NOFFuIeFmFTM11Z-CW2s';
  $location = $_GET['location'];
  $radius = $_GET['radius'];
  $types = $_GET['types'];
  $name = $_GET['name'];
  $pagetoken = $_GET['next_page'];
  $url = "https://maps.googleapis.com/maps/api/place/search/json?location=$location&radius=$radius&types=$types&name=$name&sensor=false&key=$key&pagetoken=$pagetoken";
  echo file_get_contents($url);
?>
