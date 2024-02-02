import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'

Vue.use(VueRouter)

const routes = [
    {
        path: '/login',
        name: 'login',
        component: () => import('../views/Login.vue')
    },
    {
        path: '/register',
        name: 'register',
        component: () => import('../views/Register.vue')
    },
    {
        path: '/forgetPass',
        name: 'forgetPass',
        meta: {name: "忘记密码"},
        component: () => import('../views/ForgetPass.vue')
    },
    {
        path: '/',
        name: 'home',
        component: HomeView,
        redirect: 'welcome',
        // component: () => import('../views/AboutView.vue')
        children: [
            {
                path: 'welcome',
                name: 'welcome',
                meta: {name: "系统首页"},
                component: () => import('../views/Welcome.vue')
            },
            {
                path: '/personal',
                name: 'personal',
                meta: {name: "个人信息"},
                component: () => import('../views/Personal.vue')
            },
            {
                path: '/updatePass',
                name: 'updatePass',
                meta: {name: "修改密码"},
                component: () => import('../views/UpdatePass.vue')
            },
            {
                path: 'admin',
                name: 'admin',
                meta: {name: "管理员管理"},
                redirect: 'adminview',
                component: () => import('../views/sys/SysAdmin.vue'),
                children: [
                    {
                        path: '/admin/adminview',
                        name: 'adminview',
                        meta: {name: "管理员信息",},
                        component: () => import('../views/AdminView.vue')
                    },
                ]
            },
            {
                path: 'user',
                name: 'user',
                meta: {name: "用户管理"},
                redirect: 'userview',
                component: () => import('../views/sys/SysUser.vue'),
                children: [
                    {
                        path: '/user/userview',
                        name: 'userview',
                        meta: {name: "用户信息"},
                        component: () => import('../views/UserView.vue')
                    },
                ]
            },
            {
                path: 'book',
                name: 'book',
                meta: {name: "图书管理"},
                redirect: 'bookview',
                component: () => import('../views/sys/SysBook.vue'),
                children: [
                    {
                        path: '/book/bookview',
                        name: 'bookview',
                        meta: {name: "图书信息"},
                        component: () => import('../views/BookView.vue')
                    },
                    {
                        path: '/book/category',
                        name: 'category',
                        meta: {name: "图书分类"},
                        component: () => import('../views/BookType.vue')
                    },
                    {
                        path: '/book/borrow',
                        name: 'borrow',
                        meta: {name: "图书借阅"},
                        component: () => import('../views/BookBorrow.vue')
                    },
                ]
            },
        ]
    },
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

// 解决重复路由跳转问题
const originalPush = VueRouter.prototype.push

VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}

// 路由守卫
router.beforeEach((to, from, next) => {
    if (to.path === '/login') {
        next();
    }
    const user = localStorage.getItem("user");
    if (!user && to.path !== '/login' && to.path !== '/register' && to.path !== '/forgetPass') {
        return next("/login");
    }
    next();
})
export default router
