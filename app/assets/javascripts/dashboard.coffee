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
map = null
ui = null
group = new (H.map.Group)
accGroup = new (H.map.Group)
offset = 0
geocoder = platform.getGeocodingService()
lat = null
long = null
crd = null
options =
  enableHighAccuracy: true
  timeout: 10000
  maximumAge: 0
search = new (H.places.Search)(platform.getPlacesService())
searchResult = undefined
error = undefined

err = (err) ->
  error = err
  console.log err
  return

onResult = (data) ->
  searchResult = data
#  console.log('searchResult > ', data)
  addAccomodationMarkers(searchResult)
  return

onError = (data) ->
  error = data
#  console.log('error > ', data)
  return

events = (lat, long) ->
  $.getJSON '/dashboard.json', (data) ->
    datapoints = []
    $.each data, (key, val) ->
      $.each val, (key1, val1) ->
        datapoints.push val1
        return
      return
    show crd.latitude, crd.longitude, datapoints
    return
  return

next_events = ->
  offset = offset + 1
  $.getJSON '/dashboard.json?offset=' + offset, (data) ->
    datapoints = []
    $.each data, (key, val) ->
      $.each val, (key1, val1) ->
        datapoints.push val1
        return
      return
    show crd.latitude, crd.longitude, datapoints
    return
  return

show = (lat, long, datapoints) ->
# Instantiate the map:
  if map == null
    map = new (H.Map)(document.getElementById('mapContainer'), platform.createDefaultLayers().normal.map,
      zoom: 3
      center:
        lat: lat
        lng: long)

    behavior = new (H.mapevents.Behavior)(new (H.mapevents.MapEvents)(map))
    ui  = H.ui.UI.createDefault(map, platform.createDefaultLayers())
    map.addObject group

  circleRadius = 300000
  circle = new (H.map.Circle)(new (H.geo.Point)(lat, long), circleRadius)
  map.addObject circle

  # add 'tap' event listener, that opens info bubble, to the group
  group.addEventListener 'tap', ((evt) ->
    loc = evt.target.getPosition()
    map.setZoom(14)
    map.setCenter(loc)
    ui.addBubble new (H.ui.InfoBubble)(loc, content: evt.target.getData())

    params = {q: 'hotel', at: "#{loc.lat},#{loc.lng}"}

    search.request params, {}, onResult, onError

    return
  ), false

  $('#area-size').on 'change', (event) ->
    newRadius = $(this).val()
    circle.setRadius newRadius
    $('.area-size-badge').html newRadius / 1000 + ' (km)'
    updateMarkers group, circle, newRadius, datapoints
    return

  $('#area-size').trigger 'change'

  return

addMarkerToGroup = (group, coordinate, html) ->
  marker = new (H.map.Marker)(coordinate)
  # add custom data to the marker
  marker.setData html
  group.addObject marker
  return

crd = null

focus_on_events = ->
  groups = [
    []
    []
    []
    []
  ]
  group.forEach (m) ->
    position = m.getPosition()
    index = 0
    if position.lat < 0.0 and position.lng < 0.0
      index = 0
    else if position.lat < 0.0 and position.lng > 0.0
      index = 1
    else if position.lat > 0.0 and position.lng < 0.0
      index = 2
    else
      index = 3
    console.log position.lat + '   ' + position.lng
    groups[index].push m
    return
  biggest_group = groups[0]
  groups.forEach (g) ->
    if biggest_group.length < g.length
      biggest_group = g
    console.log g.length
    return
  bounds = null
  $.each biggest_group, (k, v) ->
    position = v.getPosition()
    if bounds == null
      bounds = position.getBounds()
    else
      bounds = bounds.mergePoint(position)
    return
  map.setViewBounds bounds
  return

updateMarkers = (group, circle, newRadius, datapoints) ->
  group.removeAll()
  $.each datapoints, (key, val) ->
    `var lat`
    lat = val['coords']['lat']
    lng = val['coords']['long']
    origin = circle.getCenter()
    target = new (H.geo.Point)(lat, lng)
    if isInsideRadius(origin, target, newRadius)
      addMarkerToGroup group, {
        lat: lat
        lng: lng
      }, '<div>' + val['artist'] + ', on: ' + val['date'] + '</div>'
    return
  return

isInsideRadius = (origin, target, radius) ->
  origin.distance(target) <= radius

addAccomodationMarkers = (searchResult) ->
  accGroup.removeAll()
  accGroup = new (H.map.Group)
  $.each searchResult.results.items, (_, item) ->
    icon = new H.map.Icon(item.icon, {size: {w: 32, h: 32}})
    marker = new (H.map.Marker)({lat: item.position[0], lng: item.position[1]}, {icon: icon})
    marker.setData item.title
    accGroup.addObject marker
    return

  map.addObject(accGroup)

  accGroup.addEventListener 'tap', (evt) ->
    loc = evt.target.getPosition()
    ui.addBubble new (H.ui.InfoBubble)(loc, content: evt.target.getData())
    return
  return

document.addEventListener 'turbolinks:load', ->
  navigator.geolocation.getCurrentPosition ((pos) ->
    crd = pos.coords
    events crd.latitude, crd.longitude
    return
  ), err, options
  return
