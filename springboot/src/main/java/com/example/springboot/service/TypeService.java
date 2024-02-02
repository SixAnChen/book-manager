package com.example.springboot.service;

import com.example.springboot.entity.Params;
import com.example.springboot.entity.Type;
import com.example.springboot.mapper.TypeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TypeService {

    @Resource
    TypeMapper typeMapper;

    /**
     * 查询所有图书类型
     * @return
     */
    public List<Type> findAll() {
        return typeMapper.findAll();
    }

    /**
     * 新增图书分类
     * @param type
     */
    public void insertType(Type type) {
        typeMapper.insertSelective(type);
    }


    /**
     * 修改图书信分类
     */
    public void updateType(Type type) {
        typeMapper.updateByPrimaryKeySelective(type);
    }

    /**
     * 删除图书分类
     */
    public void deleteType(Integer id) {
        typeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 分页条件查询
     * @param params
     * @return
     */
    public PageInfo<Type> search(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Type> list = typeMapper.findBySearch(params);
        return PageInfo.of(list);
    }
}

