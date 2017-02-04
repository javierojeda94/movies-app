# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#rent_a_movie_modal').on 'show.bs.modal', (event) -> 
    $.ajax(url: "/rent_a_movie")

root = exports ? this
root.rent_movie = (movie_id) ->
  $.ajax(url: "/rent_a_movie", type: 'post', data: {
    id: movie_id
  })