<template>
  <div>
    <div class="container">
      <div class="header-home"><HeaderHome /></div>
      <div class="button"><button @click="show()">{{ textButton }}</button></div>
    </div>
    
    <div class="container-header">
    <header v-if="showHeader">
    <nav>
      <ul>
        <div>
          Selecione a data
          <InputComponent type="date" :value="currentDate" id="datePicker" />
        </div>
        <div>
          Hora Inicial
          <InputComponent
            type="time"
            value="00:00:00"
            id="initialTime"
            step="1"
          />
        </div>
        <div>
          Hora Final
          <InputComponent
            type="time"
            value="20:59:59"
            id="finalTime"
            step="1"
          />
        </div>
        
        <div>
          <ButtonComponent
            id="btn-submit"
            text="Confirmar"
            @click="updateFilterMap"
          />
        </div>
      </ul>
    </nav>
    <div>
    </div>
  </header>

    </div>
  <div id="map"></div>
  <AqiLegend class="legend" />
</template>

<script>
import { initMap, updateMap } from "@/utilities/Utilities.vue";
import ButtonComponent from "@/components/Button.vue";
import InputComponent from "@/components/Inputs.vue";
import AqiLegend from "@/components/AqiLegend.vue";


export default {
  components: {
    ButtonComponent,
    InputComponent,
    AqiLegend,
  },
  data() {
    return {
      map: null,
      markersGroup: null,
      currentDate: this.getCurrentDate(),
      showHeader: true,
      textButton: 'Esconder Filtro',
    };
  },
  methods: {
    getCurrentDate() {
      const today = new Date();
      const year = today.getFullYear();
      const month = String(today.getMonth() + 1).padStart(2, "0");
      const day = String(today.getDate()).padStart(2, "0");
      return `${year}-${month}-${day}`;
    },
    async updateFilterMap() {
      const selectedDate = document.getElementById("datePicker").value;
      const initialTime = document.getElementById("initialTime").value;
      const finalTime = document.getElementById("finalTime").value;

      // Adiciona 3 horas ao horário para corrigir temporariamente
      const initialTimeFixed = this.subtractHours(initialTime, 3);
      const finalTimeFixed = this.subtractHours(finalTime, 3);

      // const intervalHour = [initialTimeFixed, finalTimeFixed];
      // console.log(intervalHour);

      try {
        const response = await fetch(
          `/api/sensorData/?date_reference=${selectedDate}&start_time=${initialTimeFixed}&end_time=${finalTimeFixed}`,
          {
            method: "GET",
            headers: {
              accept: "application/json",
            },
          }
        );

        const data = await response.json();
        updateMap(this.markersGroup, selectedDate, data);
      } catch (error) {
        console.error("Erro ao buscar coordenadas:", error);
      }
    },
    subtractHours(time, hours) {
      const [hour, minute, second] = time.split(":").map(Number);
      const date = new Date();
      date.setHours(hour, minute, second);
      date.setHours(date.getHours() + hours);
      return date.toTimeString().split(" ")[0];
    },
    show(){
    if(this.showHeader === false){
      this.textButton = "Esconder Filtro"
      this.showHeader = true;
    }
    else{
      this.textButton = "Mostrar Filtro";
      this.showHeader = false;
    } 
  }
  },
  mounted() {
    const { map, markersGroup } = initMap("map");
    this.map = map;
    this.markersGroup = markersGroup;

    this.updateFilterMap();
    // Atualiza o mapa a cada 5 segundos
    // setInterval(this.updateFilterMap, 5000);
  },

 
};
</script>

<style scoped>
.container{
  display: flex;
  justify-content: space-between;
  width: 100%;
  background-color: #BFBEA0;;
}

.header-home{
  width: 100%;
}

.button{
  position: absolute;
  right: 20px;
  top: 35px;
}
.container-header{
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #BFBEA0;
  
}

header {
  background-color: #bfbea0;
  color: rgb(0, 0, 0);
  font-weight: bold;
  padding: 10px;
  text-align: center;
  display: flex;
  justify-content: center;
  gap: 50px;
  align-items: center;
  border-top: solid 1px black;

}

nav ul {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 60px;
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
  color: #000000;
  font-weight: bold;
  border: 1px solid #bfbea0;
  border-radius: 5px;
  width: 100px;
  height: 35px;
  cursor: pointer;
}

button{
  width: 100px;
  height: 35px;
  background-color: #000;
  color: #fff;
  border: 1px solid #fff;
  border-radius: 4px;
}

#map {
  height: 92vh;
  width: 100%;
  position: relative;
  z-index: 0;
}

.legend {
  position: absolute;
  bottom: 2vh;
  right: 0;
  z-index: 1;
}
</style>
