<script>
// Função para inicializar o mapa (chamado uma única vez)
function initMap(mapElementId) {
  // const map = L.map(mapElementId).setView([-20.298157, -40.361637], 14);

  // ***************************************************************************************************
  // ***************************************************************************************************
  // ***************************************************************************************************
  // ***************************************************************************************************
  // ***************************************************************************************************

  var osm = L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution: "© OpenStreetMap",
  });

  var osmHOT = L.tileLayer(
    "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
    {
      maxZoom: 19,
      attribution:
        "© OpenStreetMap contributors, Tiles style by Humanitarian OpenStreetMap Team hosted by OpenStreetMap France",
    }
  );

  var map = L.map(mapElementId, {
    center: [-20.298157, -40.361637],
    zoom: 14,
    layers: [osm],
  });

  var baseMaps = {
    OpenStreetMap: osm,
    "OpenStreetMap.HOT": osmHOT,
  };

  var layerControl = L.control.layers(baseMaps).addTo(map);

  var openTopoMap = L.tileLayer(
    "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
    {
      maxZoom: 19,
      attribution:
        "Map data: © OpenStreetMap contributors, SRTM | Map style: © OpenTopoMap (CC-BY-SA)",
    }
  );

  layerControl.addBaseLayer(openTopoMap, "OpenTopoMap");

  // ***************************************************************************************************
  // ***************************************************************************************************
  // ***************************************************************************************************
  // ***************************************************************************************************
  // ***************************************************************************************************

  L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution:
      '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
  }).addTo(map);

  // Cria um grupo de camadas para os círculos
  const markersGroup = L.layerGroup().addTo(map);

  // Adiciona um marcador com um popup em Vitória
  // addMarkerVitoria(map);

  return { map, markersGroup };
}

async function addMarkerVitoria(map) {
  var customMarker = L.icon({
    iconUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
    iconSize: [45, 55],
    iconAnchor: [20, 0],
  });

  var markerVitoria = L.marker([-20.29959657901295, -40.319646932035944], {
    icon: customMarker,
  }).addTo(map);
  markerVitoria.bindPopup(
    `<b>Date: </b> ""<br>
      <b>pm2_5: </b> ""<br>
      <b>temperature: </b>""<br>
      <b>humidity: </b>""<br>
      <b>typical_particle_size: </b>""<br>`
  );
  // .openPopup();
}

// Função para atualizar o mapa com novos pontos
async function updateMap(markersGroup, latitudes, longitudes, data) {
  markersGroup.clearLayers();
  // Adiciona novos círculos ao mapa
  for (let i = 0; i < latitudes.length; i++) {
    const circle = L.circle([latitudes[i], longitudes[i]], {
      color: `${getColor(data.pm2_5[i])}`,
      fillColor: `${getColor(data.pm2_5[i])}`,
      fillOpacity: 0.7,
      radius: 50,
    });
    circle.bindPopup(`
      <b>Data: </b> ${data.dateSelected[0]}<br>
      <b>pm2_5: </b> ${data.pm2_5[i]}<br>
      <b>Temperatura: </b>${data.temperature[i]}<br>
      <b>Humidade: </b>${data.humidity[i]}<br>
      <b>Tamanho típico da partícula: </b>${data.typical_particle_size[i]}<br>
    `);
    markersGroup.addLayer(circle);
  }
}

function getColor(value) {
  if (value < 4) {
    return "#3ab83a";
  } else if (value < 8) {
    return "#c2c200";
  } else if (value < 12) {
    return "#ff7e00";
  } else if (value < 16) {
    return "#ff0000";
  } else if (value < 20) {
    return "#8f3f97";
  } else {
    return "#7e0023";
  }
}

export { initMap, updateMap };
</script>
