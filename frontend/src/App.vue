<template>
  <div id="app">
    <router-view class="" :key="$route.fullPath"></router-view>
  </div>
</template>

<style>
#app {
  font-family: "IBM Plex Serif", serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.sans-serif {
  font-family: "Montserrat", sans-serif;
}
</style>
