package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Params;
import com.example.springboot.service.BookService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/book")
public class BookController {
    @Resource
    BookService bookService;

    /**
     * 新增图书信息
     */
    @PostMapping("/add")
    public Result add(@RequestBody Book book) {
        bookService.insertBook(book);
        return Result.success();
    }

    /**
     * 修改图书信息
     */
    @PutMapping("/update")
    public Result update(@RequestBody Book book) {
        bookService.updateBook(book);
        return Result.success();
    }

    /**
     * 删除图书信息
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        bookService.deleteBook(id);
        return Result.success();
    }


    /**
     * 分页条件查询
     * @param params
     * @return
     */
    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<Book> info = bookService.search(params);
        return Result.success(info);
    }
}
