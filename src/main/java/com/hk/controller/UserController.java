package com.hk.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hk.bean.Message;
import com.hk.bean.Role;
import com.hk.bean.User;
import com.hk.bean.User_Role;
import com.hk.service.UserService;
import com.hk.service.User_RoleService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    User_RoleService user_roleService;


    /**
     * 获取所有用户信息
     * @param pageNum 页数
     * @param searchString 搜索字符串
     * @return
     */
    @ResponseBody
    @RequestMapping("/getAllUsers")
    public Message getAllUsers(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum,@RequestParam(value = "searchString",defaultValue = "")String searchString){
        PageHelper.startPage(pageNum,5);
        //之后的查询即为分页查询
        List<User> userList= userService.getAllUsersWithSearch(searchString);
        //使用pageInfo包装结果
        PageInfo pageInfo =new PageInfo(userList,5);
        return  Message.success().add("pageInfo",pageInfo);
    }

    /**
     * 添加用户
     * @param user 用户对象
     * @param result 返回相关错误的对象
     * @return
     */
    @RequestMapping("/addUser")
    @ResponseBody
    public Message addUser(@Valid User user , BindingResult result){
        //检测用户名是否重复
        Message message =checkLoginName(user.getLoginName());
        if(message.getCode()==200){
            return Message.fail().add("loginName","用户名已存在");
        }
        System.out.println(user.toString());
        if(result.hasErrors()){
            //保存错误信息
            Map<String,Object> map =new HashMap<String,Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError:fieldErrors){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误的信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields",map);
        }else{
            //插入用户表
            userService.addUser(user);
            //插入身份表
            user_roleService.add_Role(new User_Role(null,user.getUserId(),user.getUserRoleID()));
            return Message.success();
        }
    }

    /**
     * 通过id获取用户详细信息
     * @param id
     * @return
     */
    @RequestMapping("/getUser")
    @ResponseBody
    public Message getUser(@RequestParam(value = "id") Integer id){
        User user =userService.getUser(id);
        List<User_Role> user_roles =user_roleService.getUserRole(id);
        return Message.success().add("user",user).add("role",user_roles);
    }

    /**
     * 更新用户信息
     * @param user
     * @param result
     * @return
     */
    @RequestMapping("/updateUser")
    @ResponseBody
    public Message updateUser(@Valid User user , BindingResult result){
        System.out.println(user.toString());
        if(result.hasErrors()){
            //保存错误信息
            Map<String,Object> map =new HashMap<String,Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError:fieldErrors){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误的信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields",map);
        }else{
            userService.updateUser(user);
            return Message.success();
        }
    }

    /**
     * 删除用户
     * @param id
     * @return
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public Message deleteUser(@RequestParam(value = "userId")Integer  id ){
        //先删除身份
        user_roleService.deleteUserRole(id);
        //再删除用户
        userService.deleteUser(id);
        return Message.success();

    }


    /**
     * 判断用户名是否相同
     * @param loginName
     * @return
     */
    @RequestMapping("/checkLoginName")
    @ResponseBody
    public Message checkLoginName(@RequestParam(value = "loginName")String loginName){
        boolean flag =userService.checkLoginName(loginName);
        if(flag) return Message.success();
        return Message.fail();
    }


    /**
     *测试。。。
     * @param pageNum
     * @return
     */
  //  @RequestMapping("/test")
 //   @ResponseBody
  //  public Message test123(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum){
  //      PageHelper.startPage(pageNum,5);
        //之后的查询即为分页查询
   //     List<User> userList= userService.getAllUsers();
        //使用pageInfo包装结果
   //     PageInfo pageInfo =new PageInfo(userList,5);
   //     return Message.success().add("pageInfo",pageInfo);
 //   }


}
