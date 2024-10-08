<script>
import HeaderHome from './HeaderHome.vue'
export default{
    name: "HomeBody",
    components:{
        HeaderHome
    }
}
</script>

<template>
    <div id="bg-image">
        <HeaderHome />
        <div id="footer"><div class="text-footer"><h1>AirQuality</h1></div></div>
    </div>
</template>

<style scoped>
@import '../assets/base.css';

    #bg-image{
        background-image: url("../assets/images/foto-bolha-editada.jpg");
        width: 100vw;
        height: 100vh;
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
    }


    #footer{
        width: 100%;
        height: 15%;
        position: absolute;
        bottom: 0;
    }

    .text-footer{
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 300px;
    }

    .text-footer > h1 {
        font-family: 'Poppins';
        color: #fff;
        font-size: 60px;
    }

</style>