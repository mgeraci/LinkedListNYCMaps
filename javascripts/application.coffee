$(->
  initialize()
)

query = ->
  key = 'AIzaSyAa5R9714gGFc7NOFFuIeFmFTM11Z-CW2s'

  #url = "http://maps.googleapis.com/maps/api/place/nearbysearch/json?
    #location=-33.8670522,151.1957362&
    #radius=500&
    #types=food&
    #name=harbour&
    #sensor=false&
    #key=#{key}".replace(/\s/g, '')

  #$.ajax({
    #url: url,
    #type: 'GET',
    #success: (data)->
      #console.log data
  #})

initialize = ->
  pyrmont = new google.maps.LatLng(-33.8665433, 151.1956316)

  map = new google.maps.Map($('#map'), {
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    center: pyrmont,
    zoom: 15
  })

  request = {
    location: pyrmont,
    radius: 500,
    types: ['store']
  }

  infowindow = new google.maps.InfoWindow()
  service = new google.maps.places.PlacesService(map)
  service.nearbySearch(request, callback)

callback = (results, status)->
  console.log results, status
  #google.maps.event.addDomListener(window, 'load', initialize)
