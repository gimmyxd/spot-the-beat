# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->
  el = $('.dropdown-trigger')
  el.dropdown()
  $('.sidenav').sidenav();
  $('.preloader-wrapper').show()
  navigator.geolocation.getCurrentPosition ((pos) ->
    crd = pos.coords
    events crd.latitude, crd.longitude
    return
  ), err, options
  return

platform = new (H.service.Platform)(
  'app_id': 'ABCiZ2b67vjKqbX6E1ZJ'
  'app_code': 'do7aaovSpr9tNPfJkLxG4Q')
geocoder = platform.getGeocodingService()
options =
  enableHighAccuracy: true
  timeout: 5000
  maximumAge: 0

err = (err) ->
  console.log err
  return

events = (lat, long) ->
  $('.preloader-wrapper').hide()
  $.getJSON '/dashboard.json', (data) ->
    datapoints = []
    $.each data, (key, val) ->
      $.each val, (key1, val1) ->
        datapoints.push val1
        return
      return
    show lat, long, datapoints
    return
  return

show = (lat, long, datapoints) ->
  # Instantiate the map:
  map = new (H.Map)(document.getElementById('mapContainer'), platform.createDefaultLayers().normal.map,
    zoom: 3
    center:
      lat: lat
      lng: long)
  behavior = new (H.mapevents.Behavior)(new (H.mapevents.MapEvents)(map))
  ui = H.ui.UI.createDefault(map, platform.createDefaultLayers())
  group = new (H.map.Group)
  map.addObject group
  # add 'tap' event listener, that opens info bubble, to the group
  group.addEventListener 'tap', ((evt) ->
    ui.addBubble new (H.ui.InfoBubble)(evt.target.getPosition(), content: evt.target.getData())
    return
  ), false
  $.each datapoints, (key, val) ->
    addMarkerToGroup group, {
      lat: val['coords']['lat']
      lng: val['coords']['long']
    }, '<div>' + val['artist'] + ', on: ' + val['date'] + '</div>'
    return
  return

addMarkerToGroup = (group, coordinate, html) ->
  marker = new (H.map.Marker)(coordinate)
  # add custom data to the marker
  marker.setData html
  group.addObject marker
  return


