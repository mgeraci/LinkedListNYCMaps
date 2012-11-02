<?php
  $key = 'AIzaSyAa5R9714gGFc7NOFFuIeFmFTM11Z-CW2s';
  echo file_get_contents("https://maps.googleapis.com/maps/api/place/search/json?location=-33.8670522,151.1957362&radius=500&sensor=false&key=$key");
?>
