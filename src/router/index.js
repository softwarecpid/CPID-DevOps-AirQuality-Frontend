import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import Map from "../views/Map.vue"

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes:[
        {
            path: '/',
            name:'home',
            component: Home
        },
        {
            path: '/map',
            name: 'Map',
            component: Map
        }
    ]

})

export default router