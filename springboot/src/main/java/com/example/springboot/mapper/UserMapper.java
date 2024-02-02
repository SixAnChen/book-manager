package com.example.springboot.mapper;

import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface UserMapper extends Mapper<User> {

    /**
     * 分页模糊查询
     * @param params
     * @return
     */
    List<User> findBySearch(@Param("params") Params params);


    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(List<Integer> ids);

    User findByNameAndPassword(@Param("name") String name, @Param("password") String password);

    @Select("select * from user where name = #{name}")
    User selectByName(@Param("name") String name);
}
