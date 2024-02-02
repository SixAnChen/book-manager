package com.example.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.example.springboot.common.Result;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import com.example.springboot.service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-10-24 17:11
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    UserService userService;

    /**
     * 新增用户信息
     */
    @PostMapping("/add")
    public Result add(@RequestBody User user) {
        userService.insertUser(user);
        return Result.success();
    }

    /**
     * 修改用户信息
     */
    @PutMapping("/update")
    public Result update(@RequestBody User user) {
        userService.updateUser(user);
        return Result.success();
    }

    /**
     * 删除用户信息
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        userService.deleteUser(id);
        return Result.success();
    }


    /**
     * 分页条件查询
     * @param params
     * @return
     */
    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<User> info = userService.search(params);
        return Result.success(info);
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @DeleteMapping("/delete/batch")
    public Result deleteUsers(@RequestBody List<Integer> ids) {
        userService.deleteByIds(ids);
        return Result.success();
    }

    /**
     * 登录
     * @param user
     * @return
     */
    @PostMapping("/login")
    public Result login(@RequestBody User user) {
        User loginUser = userService.login(user);
        return Result.success(loginUser);
    }

    /**
     * 注册
     * @param user
     * @return
     */
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        // 账号和密码不为空
        if (StrUtil.isBlank(user.getName()) || StrUtil.isBlank(user.getPassword())) {
            return Result.error("数据输入不合法");
        }
        // 对注册用户的用户名长度及密码长度进行限制
        if (user.getName().length() > 10 || user.getPassword().length() > 20) {
            return Result.error("数据输入不合法");
        }
        userService.insertUser(user);
        return Result.success();
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePass")
    public Result updatePass(@RequestBody User user) {
        userService.updatePass(user);
        return Result.success();
    }


    /**
     * 重置密码
     * @param user
     * @return
     */
    @PutMapping("/resetPass")
    public Result resetPass(@RequestBody User user) {
        if (StrUtil.isBlank(user.getName()) || StrUtil.isBlank(user.getPhone())) {
            return Result.error("数据输入不合法");
        }
        userService.resetPass(user);
        return Result.success();
    }
}
