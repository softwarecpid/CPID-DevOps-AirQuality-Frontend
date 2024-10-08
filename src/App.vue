<template>
  <div id="app">
    <RouterView />
  </div>
</template>

<script>
import Map from './views/Map.vue';
import {RouterView} from 'vue-router'

export default {
  components: {
    Map,
  },
};
</script>
