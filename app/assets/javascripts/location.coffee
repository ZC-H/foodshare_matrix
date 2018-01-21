jQuery ->
  markersArray = []
  lat_field = $('#location_latitude')
  lng_field = $('#location_longitude')
  address_field = $('#location_address')
  

  window.initMap = ->
    if $('#map').size() > 0
      map = new google.maps.Map document.getElementById('map'), {
        center: {lat: 3.1390, lng: 101.6869}
        zoom: 17
      }
      gcoder = new (google.maps.Geocoder)

      map.addListener 'click', (e) ->
        placeMarkerAndPanTo e.latLng, map
        updateFields e.latLng

      $('#find-on-map').click (e) ->
        e.preventDefault()
        placeMarkerAndPanTo {
          lat: parseInt lat_field.val(), 10
          lng: parseInt lng_field.val(), 10
        }, map

      $('#find-from-address').click (e) ->
        e.preventDefault()
        codeAddress()

      codeAddress = ->
        address = $('#location_address').val()
        gcoder.geocode { 'address': address }, (results, status) ->
          if status == 'OK'
            markersArray.pop().setMap(null) while(markersArray.length)
            marker = new google.maps.Marker
              position: results[0].geometry.location
              map: map
            map.panTo results[0].geometry.location
            markersArray.push marker
            lat_field.val null
            lng_field.val null
          else
            alert 'Geocode was not successful for the following reason: ' + status
          return
        return

  placeMarkerAndPanTo = (latLng, map) ->
    markersArray.pop().setMap(null) while(markersArray.length)
    marker = new google.maps.Marker
      position: latLng
      map: map

    map.panTo latLng
    markersArray.push marker

  updateFields = (latLng) ->
    lat_field.val latLng.lat()
    lng_field.val latLng.lng()
    address_field.val null