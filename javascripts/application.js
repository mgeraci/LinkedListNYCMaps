// Generated by CoffeeScript 1.3.3
(function() {
  var query;

  $(function() {
    return query();
  });

  query = function() {
    return $.ajax({
      url: "./request.php",
      type: 'GET',
      success: function(data) {
        return console.log(data);
      }
    });
  };

}).call(this);
