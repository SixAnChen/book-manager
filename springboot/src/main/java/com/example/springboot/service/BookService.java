package com.example.springboot.service;

import cn.hutool.core.util.RandomUtil;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Params;
import com.example.springboot.mapper.BookMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BookService {
    @Resource
    BookMapper bookMapper;

    /**
     * 新增图书信息
     */
    public void insertBook(Book book) {
        String randomNumbers = RandomUtil.randomNumbers(12);
        book.setIsbn(randomNumbers);
        bookMapper.insertSelective(book);
    }


    /**
     * 修改图书信息
     */
    public void updateBook(Book book) {
        if(book.getIsbn() == null){
            String randomNumbers = RandomUtil.randomNumbers(12);
            book.setIsbn(randomNumbers);
        }
        bookMapper.updateByPrimaryKeySelective(book);
    }

    /**
     * 删除图书信息
     */
    public void deleteBook(Integer id) {
        bookMapper.deleteByPrimaryKey(id);
    }

    /**
     * 分页条件查询
     * @param params
     * @return
     */
    public PageInfo<Book> search(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Book> list = bookMapper.findBySearch(params);
        return PageInfo.of(list);
    }

}
