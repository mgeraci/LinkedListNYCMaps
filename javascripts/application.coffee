$(->
  geocode('10552')
  #query(geocode('10552'))
)

desired = [114,151,156,153,145,144,114,151,163,164,116,131,103]
desired = [76,105,110,107,101,100,76,105,115,116,78,89,67]
results = []

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

query = (coords, radius = 10000)->
  console.log "starting a query within #{radius}m of '#{coords}'"
  $.ajax({
    type: 'GET'
    url: "./request.php"
    data:
       location: coords
       radius: radius
       types: 'food'
       name: 'coffee'
    success: (data)->
      request_results = JSON.parse(data).results
      addresses = _.map request_results, (result)->
        result.vicinity.match(/^\d+/)?[0]

      if addresses.length > 0
        console.log "we found some addresses! #{_.compact addresses}"
      else
        console.log 'no addresses found :('

      # check each address and see if it matches any of the desired chars
      # for each result,
      # is it contained in desired?
      console.log _.filter request_results, (result)->
        _.contains desired, parseInt(result.vicinity.match(/^\d+/)?[0])
  })
