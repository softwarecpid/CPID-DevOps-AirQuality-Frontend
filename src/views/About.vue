<script>
import HeaderHome from '../components/HeaderHome.vue'
export default{
    components: {
        HeaderHome
    }
}
</script>
<template>
  <div>
    <div id="header">
        <HeaderHome />
    </div>
   <section id="quality-air">
    <div class="text-title">
        <h1>índice de qualidade do Ar (AQI)</h1>
    </div>
    <div class="text">
    <p>AQI ou Air Quality Index é a principal forma de medir a qualidade do ar no mundo hoje. O Índice de Qualidade do Ar é um indicador padronizado do nível de poluição do ar numa determinada zona, e resulta de uma média aritmética calculada para cada indicador. Na aplicação usamos PM 2.5 (Particulate Matter/Material Particulado com diâmetro máximo de 2.5 microns).
    O índice visa a conversão de dados analíticos e científicos num índice de fácil compreensão que permite que a população em geral tenha um acesso mais fácil e compreensível da informação.
    No Brasil, os padrões foram instituídos pelo IBAMA, e aprovados pelo CONAMA.</p>
    </div>
   </section>
  </div>
    
</template>

<style scoped>
#header{
    width: 100%;
    background-color: #BFBEA0;
}

section#quality-air{
    margin-top: 140px;
    display: flex;
    flex-direction: column;
    align-items: start;
    justify-content:center ;
    gap: 20px;
    margin-left: 20px;
}

.text-title{
    width: 100%;
}

.text-title > h1{
    font-size: 40px;
}

.text{
    width: 60%;
}
</style>