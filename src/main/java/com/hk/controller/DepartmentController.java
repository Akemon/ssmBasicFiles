package com.hk.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hk.bean.Department;
import com.hk.bean.Message;
import com.hk.bean.User;
import com.hk.dao.DepartmentMapper;
import com.hk.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/getAllDepts")
    @ResponseBody
    public Message getAllDepts(){
        List<Department> departmentList =departmentService.getAllDepts();
        return Message.success().add("depts",departmentList);
    }

}
