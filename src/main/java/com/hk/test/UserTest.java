package com.hk.test;


import com.hk.bean.Role;
import com.hk.bean.User;
import com.hk.bean.User_Role;
import com.hk.dao.RoleMapper;
import com.hk.dao.UserMapper;
import com.hk.dao.User_RoleMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Iterator;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class UserTest {

    @Autowired
    UserMapper userMapper;

    @Autowired
    SqlSession sqlSession;

    @Autowired
    User_RoleMapper user_roleMapper;

    /*
    @Test
    public void testUserMapper(){
        System.out.println(userMapper);
        List<User> userList =userMapper.selectAllUserWithDept();
        System.out.println(userList);

        Iterator iterator =userList.iterator();
        while(iterator.hasNext()){
            User user =(User) iterator.next();
            System.out.println("姓名："+user.getName());
            System.out.println("部门："+user.getDepartment().getDeptName());
        }
*/
        //插入1000条员工数据

    @Test
     public void insertData(){
        UserMapper mapper =sqlSession.getMapper(UserMapper.class);
      //  User_RoleMapper roleMapper =sqlSession.getMapper(User_RoleMapper.class);
     //   for(int i=1;i<=1000;i++){
     //       String uid = UUID.randomUUID().toString().substring(0,5)+i;
     //       mapper.insertSelective(new User(i,uid,uid,"123",20,"男",uid+"@qq.com",2));
     //       roleMapper.insertSelective(new User_Role(null,i,4));
      //  }
        User user =new User(null,"123","123","123",20,"男","123"+"@qq.com",2);
        userMapper.insertSelective(user);
        System.out.println("id:"+user.getUserId());
    }



 //   }
    @Test
    public void testSelectRole(){
        List<User> userList =userMapper.selectAllUserWithDept("");
        Iterator iterator =userList.iterator();
        while(iterator.hasNext()){
            User user =(User)iterator.next();
            List<Role> roleList =user.getRoleList();
            System.out.println("姓名："+user.getLoginName());
            System.out.print("身份：");
            Iterator iterator1 =roleList.iterator();
            while(iterator1.hasNext()){
                Role role =(Role)iterator1.next();
                System.out.print(role.getRoleName()+",");
            }
            System.out.println();
        }
    }

}
