package com.example.springboot.controller;

import cn.hutool.core.date.DateUtil;
import com.example.springboot.common.Result;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.Reserve;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.service.ReserveService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-11-06 14:53
 */

@RestController
@RequestMapping("/reserve")
public class ReserveController {

    @Resource
    private ReserveService reserveService;
    @Resource
    private BookMapper bookMapper;

    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<Reserve> info = reserveService.findBySearch(params);
        return Result.success(info);
    }


    /**
     * 修改借阅信息
     */
    @PutMapping("/update")
    public Result update(@RequestBody Reserve reserve) {
        reserveService.update(reserve);
        return Result.success();
    }

    @PostMapping
    public Result save(@RequestBody Reserve reserve) {
        // 1. 判断图书剩余本数是否为0
        Book book = bookMapper.selectByPrimaryKey(reserve.getBookId());
        if (book.getNum() == 0) {
            return Result.error("该图书剩余本数为0,当前不能借阅");
        }
        // 2. 往借阅表里插入一条借阅记录
        reserve.setTime(DateUtil.now());
        reserveService.add(reserve);
        // 3. 对应的图书剩余本数减一
        book.setNum(book.getNum() - 1);
        bookMapper.updateByPrimaryKeySelective(book);
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        reserveService.delete(id);
        return Result.success();
    }
}
