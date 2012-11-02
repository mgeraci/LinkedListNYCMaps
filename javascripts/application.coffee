$(->
  geocode('10552')
  #query()
)

desired = [114,151,156,153,145,144,114,151,163,164,116,131,103]

geocode = (address)->
  $.ajax({
    url: "./geocode_request.php?address=#{address}",
    type: 'GET',
    success: (data)->
      location = JSON.parse(data).results[0].geometry.location
      lat = location.lat
      lng = location.lng
      coords = "#{lat},#{lng}"
      query(coords)
  })


query = (coords)->
  $.ajax({
    url: "./request.php?location=#{coords}&radius=5000&types=food&name=starbucks",
    type: 'GET',
    success: (data)->
      results = JSON.parse(data).results
      results = _.map results, (result)->
        result.vicinity.match(/^\d+/)?[0]
      console.log results
  })
