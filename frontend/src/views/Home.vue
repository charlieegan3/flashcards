<template>
  <div class="pa2">
    <div>
      <button v-for="deck in decks"
              v-on:click="currentDeckName = deck"
              class="ba bw2 b--dark-gray ph2 pv1 mr1"
              v-bind:class="{ 'b--green': currentDeckName == deck }">
        {{ deck }}
      </button>
    </div>
    <div v-if="currentCard">
        <p class="i bt b--silver pt2">{{ cards[currentCard].question }}</p>
        <p v-if="answerDisplayed" class="i bt b--silver pt2">
          {{ cards[currentCard].answer }}
        </p>
        <button v-on:click="answerDisplayed = true"
                v-if="!answerDisplayed"
                class="ba bw2 b--silver ph2 pv1 mr1 w-100">
          Reveal
        </button>
        <p v-if="answerDisplayed" class="tr">
          <button v-for="n in 3"
                  v-on:click="score(n + 2)"
                  class="ba bw2 b--dark-gray ph3 pv1 mr1">
            {{ n }}
          </button>
        </p>
    </div>
    <div>
      <p class="mv1">
        <span>{{ currentDeck.length }} cards</span> <span>({{ updatedCards().length }} updated)</span>
        <button v-on:click="save"
                v-if="updatedCards().length > 0"
                class="ba bw1 b--silver ph2">
          Save
        </button>
      </p>
	  <table class="mv0 silver f6">
        <tr v-for="card in orderedCards">
	        <td><code>{{ card.id }}</code></td>
	        <td><code>{{ card.factor }}</code></td>
	        <td><code>{{ card.schedule }}</code></td>
	        <td>{{ card.question }}</td>
        </tr>
	  </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import supermemo2 from 'supermemo2';

export default {
  name: 'home',
  created() {
    axios.get("/api/cards.json").then(({ data }) => {
      this.setCards(data);
    }).catch(function (error) {
      console.log(error);
    })
  },
  data() {
    return {
      cards: {},
      decks: [],
      currentDeck: [],
      currentDeckName: "",
      currentCard: null,
      answerDisplayed: false
    }
  },
  methods: {
    cardArray: function() { return Object.values(this.cards) },
    deckCards: function() {
      var currentDeckName = this.currentDeckName;
      return _.filter(this.cardArray(), function(c) { return c.deck == currentDeckName; });
    },
    updatedCards: function() {
      return _.filter(this.cardArray(), function(c) { return c.updated; });
    },
    setCurrentCard: function() {
      this.currentCard = this.orderedCards[0].id;
    },
    score: function(quality) {
      var c = this.cards[this.currentCard];
      let ret = supermemo2(quality, c.schedule, c.factor);
      c.factor = ret.factor;
      c.schedule = ret.schedule;
      c.updated = true;
      this.cards[c.id] = c;
      this.setCurrentCard();
      this.answerDisplayed = false;
      this.save();
    },
    setCards: function(data) {
      var cards = {};
      _.forEach(data, function(c) { cards[c.id] = c })
      this.cards = cards;
    },
    save: function() {
      axios.post("/api/cards", this.updatedCards()).then(({ data }) => {
        this.setCards(data);
      }).catch(function (error) {
        console.log(error);
      })
    }
  },
  watch: {
    cards: function() {
      this.decks = this._.map(this.cardArray(), function (e) {
        return e.deck;
      });
      this.decks = this._.uniqBy(this.decks, function (e) { return e });
      if (this.currentDeckName == "")
          this.currentDeckName = this.decks[0];
    },
    currentDeckName: function() {
      var currentDeckName = this.currentDeckName;
      this.currentDeck = _.filter(this.cards, function(o) { return o.deck == currentDeckName });
    },
    currentDeck: function() {
      if (this.currentDeck.length > 0)
        this.setCurrentCard();
    }
  },
  computed: {
	orderedCards: function() {
      return _.orderBy(this.deckCards(), ['schedule'], ['asc']);
	}
  },
  components: { }
}
</script>
