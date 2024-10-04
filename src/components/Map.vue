<template>
  <header>
    <!-- <h1>Header</h1> -->
    <nav>
      <ul>
        <div>
          Selecione a data
          <input type="date" value="2024-10-03" id="datePicker" />
        </div>
        <div>
          Hora Inicial
          <input type="time" value="00:00:00" id="initialTime" step="1" />
          Hora Final
          <input type="time" value="23:59:59" id="finalTime" step="1" />
        </div>
        <div>
          <button id="btn-submit">Confirmar</button>
        </div>
      </ul>
    </nav>
  </header>
  <div id="map"></div>
</template>

<!-- <script>
import {
  initMap,
  updateMap,
  fetchCoordinates,
  selectDates,
  fetchCoordinatesFilter,
} from "@/utilities/Utilities.vue";

export default {
  data() {
    return {
      map: null,
      markersGroup: null,
    };
  },
  methods: {
    async fetchCoordinatesAndUpdateMap() {
      try {
        const { latitudes, longitudes } = await fetchCoordinates();
        updateMap(this.markersGroup, latitudes, longitudes);
      } catch (error) {
        console.error("Erro ao atualizar o mapa:", error);
      }
    },
    async fetchCoordinatesAndUpdateMap2() {
      try {
        const { latitudes, longitudes } = await fetchCoordinatesFilter();
        updateMap(this.markersGroup, latitudes, longitudes);
      } catch (error) {
        console.error("Erro ao atualizar o mapa:", error);
      }
    },
  },

  //Chama initMap para inicializar o mapa quando o componente é montado.
  mounted() {
    selectDates(
      document.getElementById("btn-submit"),
      document.getElementById("datePicker"),
      document.getElementById("initialTime"),
      document.getElementById("finalTime")
    );
    const { map, markersGroup } = initMap("map");
    this.map = map;
    this.markersGroup = markersGroup;
    this.fetchCoordinatesAndUpdateMap();

    //Configura um intervalo para atualizar as coordenadas a cada 5 segundos.
    setInterval(() => this.fetchCoordinatesAndUpdateMap(), 5000);
  },
};
</script> -->

<script>
import { initMap, updateMap } from "@/utilities/Utilities.vue";
import axios from "axios";

export default {
  data() {
    return {
      map: null,
      markersGroup: null,
    };
  },
  methods: {
    async fetchCoordinates() {
      try {
        const response = await axios.get("http://localhost:3000/updateData");
        const data = response.data;

        if (data.latitudes.length === data.longitudes.length) {
          const negativeLatitudes = data.latitudes.map((lat) => -Math.abs(lat));
          const negativeLongitudes = data.longitudes.map(
            (long) => -Math.abs(long)
          );

          updateMap(this.markersGroup, negativeLatitudes, negativeLongitudes);
        }
      } catch (error) {
        console.error("Erro ao buscar coordenadas:", error);
      }
    },
    async updateFilterMap() {
      const selectedDate = document.getElementById("datePicker").value;
      const initialTime = document.getElementById("initialTime").value;
      const finalTime = document.getElementById("finalTime").value;

      // Adiciona 3 horas ao horário para corrigir temporariamente
      const initialTimeFixed = this.subtractHours(initialTime, 3);
      const finalTimeFixed = this.subtractHours(finalTime, 3);

      const intervalHour = [initialTimeFixed, finalTimeFixed];
      console.log(intervalHour);

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

        if (data.latitudes.length === data.longitudes.length) {
          const negativeLatitudes = data.latitudes.map((lat) => -Math.abs(lat));
          const negativeLongitudes = data.longitudes.map(
            (long) => -Math.abs(long)
          );

          updateMap(this.markersGroup, negativeLatitudes, negativeLongitudes);
        } else {
          console.error(
            "Arrays de Latitudes e Longitudes têm tamanhos diferentes."
          );
        }
      } catch (error) {
        console.error("Erro ao buscar coordenadas:", error);
      }
    },
    subtractHours(time, hours) {
      const [hour, minute, second] = time.split(':').map(Number);
      const date = new Date();
      date.setHours(hour, minute, second);
      date.setHours(date.getHours() + hours);
      return date.toTimeString().split(' ')[0];
    },
  },
  mounted() {
    const { map, markersGroup } = initMap("map");
    this.map = map;
    this.markersGroup = markersGroup;

    const button = document.getElementById("btn-submit");
    button.addEventListener("click", this.updateFilterMap);

    this.fetchCoordinates();
    // Atualiza o mapa a cada 5 segundos
    // setInterval(this.fetchCoordinates, 5000);
  },
};
</script>

<style>
header {
  background-color: #0b7425;
  color: rgb(255, 255, 255);
  font-weight: bold;
  padding: 10px;
  text-align: center;
  height: 10vh;
  display: flex;
  justify-content: center;
  gap: 50px;
  align-items: center;
}

nav ul {
  display: flex;
  justify-content: center;
  gap: 50px;
  list-style: none;
  padding: 0;
}

nav ul div {
  display: flex;
  align-items: center;
  gap: 10px;
}

nav ul div input {
  padding: 5px;
}

nav ul div input[type="date"],
nav ul div input[type="time"] {
  width: 150px;
  border-radius: 4px;
  border: none;
}

nav ul div button {
  padding: 5px;
  background-color: #ffffff;
  color: #0b7425;
  font-weight: bold;
  border: 1px solid #0b7425;
  border-radius: 5px;
  width: 100px;
  height: 35px;
  cursor: pointer;
}

#map {
  height: 90vh;
  width: 100%;
}
</style>
