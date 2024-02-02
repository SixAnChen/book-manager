package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.entity.Type;
import com.example.springboot.entity.Params;
import com.example.springboot.service.TypeService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/type")
public class TypeController {

    @Resource
    TypeService typeService;

    @GetMapping
    public Result findAll() {
        return Result.success(typeService.findAll());
    }

    /**
     * 新增图书分类
     */
    @PostMapping("/add")
    public Result add(@RequestBody Type type) {
        typeService.insertType(type);
        return Result.success();
    }

    /**
     * 修改图书分类
     */
    @PutMapping("/update")
    public Result update(@RequestBody Type type) {
        typeService.updateType(type);
        return Result.success();
    }

    /**
     * 删除图书分类
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        typeService.deleteType(id);
        return Result.success();
    }


    /**
     * 分页条件查询
     * @param params
     * @return
     */
    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<Type> info = typeService.search(params);
        return Result.success(info);
    }

}
