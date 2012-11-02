<?php
  $address = $_GET['address'];
  echo file_get_contents("https://maps.googleapis.com/maps/api/geocode/json?address=$address&&sensor=true");
?>
