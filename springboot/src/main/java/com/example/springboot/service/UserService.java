package com.example.springboot.service;

import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-10-24 17:04
 */
@Service
public class UserService {

    @Resource
    UserMapper userMapper;
    private static final String DEFAULT_PASS = "123456";  //默认密码

    /**
     * 新增用户信息
     */
    public void insertUser(User user) {
        User db_user = userMapper.selectByName(user.getName());
        if (db_user != null) {
            throw new ServiceException("用户名已存在");
        }
        userMapper.insertSelective(user);
    }


    /**
     * 修改用户信息
     */
    public void updateUser(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 删除用户信息
     */
    public void deleteUser(Integer id) {
        userMapper.deleteByPrimaryKey(id);
    }

    /**
     * 分页条件查询
     * @param params
     * @return
     */
    public PageInfo<User> search(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<User> list = userMapper.findBySearch(params);
        return PageInfo.of(list);
    }


    /**
     * 批量删除
     * @param ids
     */
    public void deleteByIds(List<Integer> ids) {
        userMapper.deleteByIds(ids);
    }


    /**
     * 登录
     * @param user
     * @return
     */
    public User login(User user) {
        // 1. 进行一些非空判断
        if (user.getName() == null || "".equals(user.getName())) {
            throw new ServiceException("用户名不能为空");
        }
        if (user.getPassword() == null || "".equals(user.getPassword())) {
            throw new ServiceException("密码不能为空");
        }
        // 2. 从数据库里面根据这个用户名和密码去查询对应的管理员信息，
        User db_user = userMapper.findByNameAndPassword(user.getName(), user.getPassword());
        if (db_user == null) {
            // 如果查出来没有，那说明输入的用户名或者密码有误，提示用户，不允许登录
            throw new ServiceException("用户名或密码输入错误");
        }

        // 状态判断
        if(!db_user.getStatus()){
            throw new ServiceException("用户已被禁用,请联系管理员");
        }

        // 角色判断
        if(!user.getRole().equals(db_user.getRole())){
            throw new ServiceException("用户名或密码输入错误");
        }

        // 如果查出来了有，那说明确实有这个管理员，而且输入的用户名和密码都对；
        return db_user;
    }

    /**
     * 修改密码
     * @param user
     */
    public void updatePass(User user) {
        // 获取前端参数传递的旧密码参数值
        String oldPassword = user.getOldPassword();
        // 获取前端传递的密码参数值
        String password = user.getPassword();
        // 比较是否一致
        if (!oldPassword.equals(user.getPassword())) {
            throw new ServiceException("旧密码错误！");
        }

        if(user.getNewPassword().equals(user.getPassword())){
            throw new ServiceException("新密码不能与旧密码一致！");
        }
        // 设置新密码
        user.setPassword(user.getNewPassword());
        userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 重置密码
     * @param user
     */
    public void resetPass(User user) {
        User db_user = userMapper.selectByName(user.getName());
        if (db_user == null) {
            throw new ServiceException("用户不存在");
        }
        if (!user.getPhone().equals(db_user.getPhone())) {
            throw new ServiceException("手机号验证错误");
        }
        db_user.setPassword(DEFAULT_PASS);
        userMapper.updateByPrimaryKeySelective(db_user);
    }
}
