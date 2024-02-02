import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
// import './assets/css/theme/index.css'
import './assets/css/global.css'
import './assets/css/iconfont/iconfont.css'



import AtComponents from 'at-ui' // 引入组件样式
Vue.use(AtComponents)
import 'at-ui-style'

Vue.use(ElementUI, {size: 'small'});
Vue.config.productionTip = false

new Vue({
    router,
    render: h => h(App)
}).$mount('#app')
