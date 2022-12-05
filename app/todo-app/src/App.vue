<script setup>
import {ref, onMounted, computed, watch} from 'vue';

const todos = ref([]);
const name = ref('');

const input_content = ref('');
const input_category = ref(null);
const todos_asc = computed(() => todos.value.sort((a,b) => {
  return b.createdAt - a.createdAt;
}))

const addTodo = () => {

  if (input_content.value.trim() === ''  ||  input_category.value ===  null)  {
    return
  }

  todos.value.push({
    content: input_content.value,
    category: input_category.value,
    done: false,
    createdAt: new Date().getTime(),
  })
};

const removeTodo = todo => {
  console.log(`removeTODO  ${todo}`);
  console.log(todo);

  todos.value =  todos.value.filter((t) => t !== todo)
}

watch(todos, (newVal) => {
  // deepoption：配列の中のいずれかが変更なったら、起動するようになる
  localStorage.setItem('todos',  JSON.stringify(newVal));
}, {deep: true})

watch(name, (newVal) => {
  // localSTorage にinput値を設定
  localStorage.setItem('name',  newVal);
})

onMounted(() => {
  // 再アクセスしたとき、データが登録されるようにする
  name.value = localStorage.getItem('name') || '';
  todos.value =  JSON.parse(localStorage.getItem('todos')) ||  [];
})

</script>
<template>
  <main class="app">
    <section class="greeting">
      <h2 class="title">
        こんにちは,
        <input type="text" placeholder="name here" v-model="name">
      </h2>
    </section>

    <section class="create-todo">
      <h3>CREATE A TODO</h3>
      <form  @submit.prevent="addTodo">
        <h4>今日のtodoは？</h4>
        <input type="text" placeholder="todo" v-model="input_content">
        <h4>カテゴリ</h4>

        <div class="options">
          <label >
            <input type="radio" name="category" value="business" v-model="input_category">
            <span class="bubble business"></span>
            <div>
              仕事
            </div>
          </label>
          <label >
            <input type="radio" name="category" value="personal" v-model="input_category">
            <span class="bubble personal"></span>
            <div>
              プライベート
            </div>
          </label>
        </div>
        <input type="submit" value="TODOリストを追加"/>
      </form>
    </section>

    <section class="todo-list">
      <h3>TODO LIST</h3>
      <div class="list">
        <div v-for="todo in todos_asc" :class="`todo-item ${todo.done && 'done'}`">
          <label>
            <input type="checkbox" v-model="todo.done"/>
            <span :class="`bubble ${todo.category}`"></span>
          </label>

          <div class="todo-content">
            <input type="text"  v-model="todo.content">
          </div>

          <div class="actions">
            <button class="delete" @click="removeTodo(todo)">削除</button>
          </div>
        </div>
      </div>
    </section>

  </main>
</template>

<style scoped>
</style>
