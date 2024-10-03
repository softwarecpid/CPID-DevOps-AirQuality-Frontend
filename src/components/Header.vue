<template>
  <header>
    <!-- <h1>Header</h1> -->
    <nav>
      <ul>
        <div>
          Selecione a data
          <input type="date" value="2024-10-02" id="datePicker" />
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
</template>

<script>
import { selectDates } from "@/utilities/Utilities.vue";

export default {
    mounted() {
      selectDates(
        document.getElementById("btn-submit"),
        document.getElementById("datePicker"),
        document.getElementById("initialTime"),
        document.getElementById("finalTime")
      );
    },
//   data() {
//     return {
//       map: null,
//       markersGroup: null,
//     };
//   },
//   methods: {
//     async fetchCoordinatesAndUpdateMap() {
//       try {
//         const { latitudes, longitudes } = await fetchCoordinates();
//         updateMap(this.markersGroup, latitudes, longitudes);
//       } catch (error) {
//         console.error("Erro ao atualizar o mapa:", error);
//       }
//     },
//   },
//   mounted() {
//     selectDates(
//       document.getElementById("btn-submit"),
//       document.getElementById("datePicker"),
//       document.getElementById("initialTime"),
//       document.getElementById("finalTime")
//     );
//     const { map, markersGroup } = initMap('map');
//     this.map = map;
//     this.markersGroup = markersGroup;
//     this.fetchCoordinatesAndUpdateMap();
//   }
};
</script>

<style scoped>
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
</style>
