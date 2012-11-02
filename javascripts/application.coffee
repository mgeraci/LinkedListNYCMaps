$(->
  geocode('10001')
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

query = (coords, radius = 20000, next_page = false)->
  console.log "starting a #{'next page ' if next_page?}query within #{radius}m of '#{coords}'"

  if next_page
    data =
      next_page: next_page
  else
    data =
       location: coords
       radius: radius
       types: 'food'
       name: 'coffee'

  $.ajax({
    type: 'GET'
    url: "./request.php"
    data: data
    success: (data)->
      response = JSON.parse(data)
      request_results = response.results
      console.log response

      # make a simple array of addresses
      addresses = _.map request_results, (result)->
        result.vicinity.match(/^\d+/)?[0]

      if addresses.length > 0
        console.log "we found some addresses to search! #{_.compact addresses}"
        parseResults(request_results)

        # do the next page if next_page_token exists
        if response.next_page_token?
          console.log 'waiting 3s for the next page token to become valid'
          _.delay(->
            query(coords, radius, response.next_page_token)
          3000)
      else
        console.log 'no addresses found in this search :('
  })

# given an array of address results, see if any of the street numbers
# are present in the "desired" array
parseResults = (request_results)->
  # check each address and see if it matches any of the desired chars
  # for each result,
  # is it contained in desired?
  results = _.union results, _.filter request_results, (result)->
    _.contains desired, parseInt(result.vicinity.match(/^\d+/)?[0])

  # remove any matches from the "desired" array
  _.each request_results, (result)->
    desired = _.reject desired, (num)->
      return num == parseInt(result.vicinity.match(/^\d+/)?[0])

  console.log "current results:", results
  console.log "but we're still looking for #{desired}"
