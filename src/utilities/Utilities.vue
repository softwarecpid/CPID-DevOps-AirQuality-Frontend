<script>
// Função para inicializar o mapa (chamado uma única vez)
function initMap(mapElementId) {
  const map = L.map(mapElementId).setView([-20.298157, -40.361637], 14);

  L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution:
      '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
  }).addTo(map);

  // Cria um grupo de camadas para os círculos
  const markersGroup = L.layerGroup().addTo(map);

  addMarkerVitoria(map);

  return { map, markersGroup };
}

async function addMarkerVitoria(map) {
  const mediaPM2_5 = await getMediaPM2_5();
  const mediaTemperature = await getMediaTemperature();
  const mediaHumidity = await getMediaHumidity();
  const mediaTypicalParticleSize = await getMediaTypicalParticleSize();
  const date = await getDate();

  // Adiciona um marcador com um popup em Vitória

  var customMarker = L.icon({
    iconUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
    iconSize: [45, 55],
    iconAnchor: [20, 0],
  });

  var markerVitoria = L.marker([-20.29959657901295, -40.319646932035944], {
    icon: customMarker,
  }).addTo(map);
  markerVitoria.bindPopup(
    `<b>Date: </b> ${date}<br>
      <b>pm2_5: </b> ${mediaPM2_5}<br>
      <b>temperature: </b>${mediaTemperature}<br>
      <b>humidity: </b>${mediaHumidity}<br>
      <b>typical_particle_size: </b>${mediaTypicalParticleSize}<br>`
  );
  // .openPopup();
}

// Função para atualizar o mapa com novos pontos
async function updateMap(markersGroup, latitudes, longitudes) {
  markersGroup.clearLayers();

  // Obter dados adicionais
  const date = await getDate();
  const pm2_5 = await getPM2_5();
  const temperature = await getTemperature();
  const humidity = await getHumidity();
  const typicalParticleSize = await getTypicalParticleSize();

  // Adiciona novos círculos ao mapa
  for (let i = 0; i < latitudes.length; i++) {
    const circle = L.circle([latitudes[i], longitudes[i]], {
      color: "red",
      fillColor: "#f03",
      fillOpacity: 0.2,
      radius: 50,
    });
    circle.bindPopup(`
      <b>Data: </b> ${date}<br>
      <b>pm2_5: </b> ${pm2_5[i]}<br>
      <b>Temperatura: </b>${temperature[i]}<br>
      <b>Humidade: </b>${humidity[i]}<br>
      <b>Tamanho típico da partícula: </b>${typicalParticleSize[i]}<br>
    `);
    markersGroup.addLayer(circle);
  }
}

async function getPM2_5() {
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();

    return data.pm2_5;
  } catch (error) {
    console.error("Erro ao buscar pm2_5:", error);
  }
}

async function getTemperature() {
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();

    return data.temperature;
  } catch (error) {
    console.error("Erro ao buscar temperature:", error);
  }
}

async function getHumidity() {
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();

    return data.humidity;
  } catch (error) {
    console.error("Erro ao buscar humidity:", error);
  }
}

async function getTypicalParticleSize() {
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();

    return data.typical_particle_size;
  } catch (error) {
    console.error("Erro ao buscar typical_particle_size:", error);
  }
}

async function getMediaPM2_5() {
  let media = 0;
  let sum = 0;
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();
    const pm2_5 = data.pm2_5;

    for (let i = 0; i < pm2_5.length; i++) {
      sum += Number(pm2_5[i]);
    }
    media = (sum / pm2_5.length).toFixed(2);
    return media;
  } catch (error) {
    console.error("Erro ao buscar pm2_5:", error);
  }
}

async function getMediaTemperature() {
  let media = 0;
  let sum = 0;
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();
    const temperature = data.temperature;

    for (let i = 0; i < temperature.length; i++) {
      sum += Number(temperature[i]);
    }
    media = (sum / temperature.length).toFixed(2);
    return media;
  } catch (error) {
    console.error("Erro ao buscar temperature:", error);
  }
}

async function getMediaHumidity() {
  let media = 0;
  let sum = 0;
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();
    const humidity = data.humidity;

    for (let i = 0; i < humidity.length; i++) {
      sum += Number(humidity[i]);
    }
    media = (sum / humidity.length).toFixed(2);
    return media;
  } catch (error) {
    console.error("Erro ao buscar humidity:", error);
  }
}

async function getMediaTypicalParticleSize() {
  let media = 0;
  let sum = 0;
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();
    const typical_particle_size = data.typical_particle_size;

    for (let i = 0; i < typical_particle_size.length; i++) {
      sum += Number(typical_particle_size[i]);
    }
    media = (sum / typical_particle_size.length).toFixed(2);
    return media;
  } catch (error) {
    console.error("Erro ao buscar typical_particle_size:", error);
  }
}

async function getDate() {
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();
    const date = data.date;
    return date[0];
  } catch (error) {
    console.error("Erro ao buscar data:", error);
  }
}

function selectDates(button, datePicker, initialTime, finalTime) {
  button.addEventListener("click", () => {
    const selectedDate = datePicker.value;
    const selectedInitialTime = initialTime.value;
    const selectedFinalTime = finalTime.value;

    const intervalHour = [selectedInitialTime, selectedFinalTime];

    // exportDatas(selectedDate, intervalHour);
    fetchCoordinatesFilter(selectedDate, intervalHour);
  });
}

async function exportDatas(selectedDate, intervalHour) {
  try {
    const response = await fetch("http://localhost:3000/sensorData", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        date: selectedDate,
        timeRange: intervalHour,
      }),
    });
    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Erro ao buscar data:", error);
  }
}

async function fetchCoordinates() {
  try {
    const response = await fetch("http://localhost:3000/updateData");
    const data = await response.json();

    if (data.latitudes.length === data.longitudes.length) {
      const negativeLatitudes = data.latitudes.map((lat) => -Math.abs(lat));
      const negativeLongitudes = data.longitudes.map((long) => -Math.abs(long));

      return { latitudes: negativeLatitudes, longitudes: negativeLongitudes };
    } else {
      console.error("Latitudes and longitudes arrays have different lengths.");
    }
  } catch (error) {
    console.error("Erro ao buscar coordenadas:", error);
  }
}

async function fetchCoordinatesFilter(selectedDate, intervalHour) {
  try {
    const response = await fetch("http://localhost:3000/sensorData", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        date: selectedDate,
        timeRange: intervalHour,
      }),
    });

    const data = await response.json();
    console.log(data);

    if (data.latitudes.length === data.longitudes.length) {
      const negativeLatitudes = data.latitudes.map((lat) => -Math.abs(lat));
      const negativeLongitudes = data.longitudes.map((long) => -Math.abs(long));

      return { latitudes: negativeLatitudes, longitudes: negativeLongitudes };
    } else {
      console.error("Latitudes and longitudes arrays have different lengths.");
    }
  } catch (error) {
    console.error("Erro ao buscar coordenadas:", error);
  }
}

export {
  initMap,
  updateMap,
  exportDatas,
  selectDates,
  fetchCoordinates,
  fetchCoordinatesFilter,
};
</script>
