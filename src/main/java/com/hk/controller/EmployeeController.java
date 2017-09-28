package com.hk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {



    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum, Model model){
     //   PageHelper.startPage(pageNum,5);
       //之后的查询即为分页查询
      //  List<Employee> emps= employeeService.getAllEmployees();
        //使用pageInfo包装结果
      //  PageInfo pageInfo =new PageInfo(emps,5);
        model.addAttribute("pageInfo","呵呵哒");
        return "index";
    }

}
