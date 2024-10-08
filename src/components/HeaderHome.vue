<script>
export default{
    name: "HeaderHome",
}
</script>
<template>
    <div>
        <header id="header-home">
            <nav>
                <div class="span-links"><router-link to= "/" class="router-link"><span>Início</span></router-link></div>
                <div class="span-links"><router-link to="/map" class="router-link"><span>Mapa</span></router-link></div>
                <div class="span-links"><span>Sobre</span></div>
               
            </nav>
        </header>
    </div>
</template>
<style scoped>
    @import '../assets/base.css';

    header#header-home{
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 70px;
    }

    nav{
        display: flex;
        width: 60%;
        justify-content: space-between;
        gap: 40px;
        cursor: pointer;
    }

    div.span-links{
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid black;
        width: 100px;
        height: 40px;
        border-radius: 10px;
    }

    .router-link{
        text-decoration: none;
        color: black;
    }
    span{
        font-family: 'Poppins';
        font-weight: bolder;
    }
</style>