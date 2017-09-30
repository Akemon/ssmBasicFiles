package com.hk.test;


import com.hk.bean.User;
import com.hk.dao.UserMapper;
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

        //插入1000条员工数据
    /*
        UserMapper mapper =sqlSession.getMapper(UserMapper.class);
          for(int i=0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new User(null,uid,uid,"123",20,"男",uid+"@qq.com",2));
        }
         */

    }
}
