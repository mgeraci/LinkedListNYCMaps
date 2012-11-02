$(->
  query()
)

query = ->
  $.ajax({
    url: "./request.php",
    type: 'GET',
    success: (data)->
      console.log data
  })
