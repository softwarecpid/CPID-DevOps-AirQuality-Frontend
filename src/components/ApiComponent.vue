<template>
  <div>
    <h1>Dados da API</h1>
    <ul v-if="data.length">
      <li v-for="(item, index) in data" :key="index">{{ item }}</li>
    </ul>
    <p v-else>Carregando dados...</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      data: [],
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    async fetchData() {
      try {
        const response = await axios.get("http://localhost:3000/updateData");
        this.data = response.data;
        console.log(this.data);
      } catch (error) {
        console.error("Erro ao buscar dados:", error);
      }
    },
  },
};
</script>
