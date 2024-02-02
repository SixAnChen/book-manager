package com.example.springboot.service;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.Reserve;
import com.example.springboot.entity.User;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.mapper.ReserveMapper;
import com.example.springboot.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-11-06 14:43
 */
@Service
public class ReserveService {

    @Resource
    UserMapper userMapper;
    @Resource
    BookMapper bookMapper;
    @Resource
    ReserveMapper reserveMapper;


    public PageInfo<Reserve> findBySearch(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Reserve> list = reserveMapper.findBySearch(params);
        if (CollectionUtil.isEmpty(list)) {
            return PageInfo.of(new ArrayList<>());
        }
        for (Reserve reserve : list) {
            if (ObjectUtil.isNotEmpty(reserve.getBookId())) {
                Book book = bookMapper.selectByPrimaryKey(reserve.getBookId());
                if (ObjectUtil.isNotEmpty(book)) {
                    reserve.setBookName(book.getName());
                }
            }
            if (ObjectUtil.isNotEmpty(reserve.getUserId())) {
                User user = userMapper.selectByPrimaryKey(reserve.getUserId());
                if (ObjectUtil.isNotEmpty(user)) {
                    reserve.setUserName(user.getName());
                }
            }
        }
        return PageInfo.of(list);
    }

    public void add(Reserve reserve) {
        reserveMapper.insertSelective(reserve);
    }

    public void update(Reserve reserve) {
        reserveMapper.updateByPrimaryKeySelective(reserve);
    }

    public void delete(Integer id) {
        reserveMapper.deleteByPrimaryKey(id);
    }
}
