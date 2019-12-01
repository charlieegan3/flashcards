import Vue from 'vue'
import App from './App.vue'
import router from './router'
import "normalize.css"
import "./assets/styles/tachyons.css"
import VueLodash from 'vue-lodash'

Vue.use(VueLodash)

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
