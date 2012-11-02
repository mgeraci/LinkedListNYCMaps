$(->
  geocode('10552')
  #query()
)

geocode = (address)->
  $.ajax({
    url: "./geocode_request.php?address=#{address}",
    type: 'GET',
    success: (data)->
      location = JSON.parse(data).results[0].geometry.location
      lat = location.lat
      lng = location.lng
      console.log lat, lng
  })


query = ->
  $.ajax({
    url: "./request.php?location=-33.8670522,151.1957362&radius=500&types=food&name=starbucks",
    type: 'GET',
    success: (data)->
      console.log data
  })
