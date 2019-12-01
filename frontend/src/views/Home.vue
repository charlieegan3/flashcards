<template>
  <div>
    hello
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'home',
  created() {
    axios.get("/data/index.json").then(({ data }) => {
      this.data = data;
    }).catch(function (error) {
      console.log(error);
    })
  },
  data() { },
  watch: { },
  components: { }
}
</script>
