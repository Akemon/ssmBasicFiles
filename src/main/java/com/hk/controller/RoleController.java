package com.hk.controller;


import com.hk.bean.Message;
import com.hk.bean.Role;
import com.hk.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class RoleController {
    @Autowired
    RoleService roleService;

    /**
     * 获取所有身份
     * @return
     */
    @RequestMapping("/getAllRoles")
    @ResponseBody
    public Message getAllRoles(){
        List<Role> roleList =roleService.getAllRoles();
        return Message.success().add("roles",roleList);
    }
}
