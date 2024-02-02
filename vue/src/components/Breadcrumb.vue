<template>
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item v-for="(crumb, index) in breadcrumbs" :key="index">
      <router-link :to="crumb.to">{{ crumb.label }}</router-link>
    </el-breadcrumb-item>
  </el-breadcrumb>
</template>

<script>
export default {
  computed: {
    breadcrumbs() {
      const crumbs = [];
      const matchedRoutes = this.$route.matched;

      for (const route of matchedRoutes) {
        if (route.meta && route.meta.name) {
          crumbs.push({
            label: route.meta.name,
            to: route.path,
          });
        }

        if (route.meta && route.meta.dynamic && this.$route.params) {
          // 处理动态路由参数
          for (const paramKey in this.$route.params) {
            const paramValue = this.$route.params[paramKey];
            if (route.path.includes(`:${paramKey}`)) {
              route.meta.name = route.meta.name.replace(
                  `:${paramKey}`,
                  paramValue
              );
            }
          }

          crumbs.push({
            label: route.meta.name,
            to: route.path,
          });
        }
      }

      return crumbs;
    },
  },
};
</script>
