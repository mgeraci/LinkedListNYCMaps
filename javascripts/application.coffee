$(->
  geocode('10001')
  #jump('40.76026190,-73.99328720')
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

# if you get the viewport for this coord's square dimensions,
# move to an adjacent square
jump = (coords)->
  $.ajax({
    url: "./geocode_request.php?address=#{coords}",
    type: 'GET',
    success: (data)->
      request_results = JSON.parse(data).results[0]
      viewport = request_results.geometry.viewport

      # calculate the width and height of the zip-code viewport
      width = viewport.northeast.lng - viewport.southwest.lng
      height = viewport.northeast.lat - viewport.southwest.lat

      # get a random adjacent zip-code sized square
      matrix = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
      index = Math.floor(Math.random() * matrix.length)

      multiplier = 7
      new_lat = request_results.geometry.location.lat + matrix[index][1] * height * multiplier
      new_lng = request_results.geometry.location.lng + matrix[index][0] * width * multiplier

      query("#{new_lat},#{new_lng}")
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

        # otherwise, jump!
        else
          console.log "looks like we're out of pages, so let's jump to an adjacent area"
          jump(coords)
      else
        console.log "no addresses found in this search, so let's jump to an adjacent area"
        jump(coords)
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

  if desired.length == 0
    console.log 'oh shit, we found them all!'
    return false
