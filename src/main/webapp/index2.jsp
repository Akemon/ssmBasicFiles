<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <meta charset="UTF-8" />
    <script type="text/javascript" src="static/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css" />
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

</head>
<body>
<script type="text/javascript">
    <!--获取所有用户信息 -->
    $(document).ready(function () {
        //alert("进入初始化");
        toPage(1);
        })
    //页面跳转
    function toPage(pageNum) {
        var searchString =$("#searchString").val();
        $.ajax({
            url:"http://localhost:8080/getAllUsers",
            type:"POST",
            data:"pageNum="+pageNum+"&searchString="+searchString,
            success:function (result) {
                console.log(result);
                //显示用户信息
                showUserMessages(result);
                //显示分布信息
                showSplitPageMessage(result);
                //显示页码信息
                showPagesMessage(result);
            }
        })
    }

    //显示用户信息
    function showUserMessages(result) {

        $("#user_table tbody").empty();
        var users =result.extend.pageInfo.list;
        $.each(users,function (index,item) {
          //  alert(item.name);
            var checkbox =$("<th></th>").append($("<input></input>").prop("type","checkbox").addClass("check_item"));
            var id =$("<th></th>").append(item.userId);
            var name =$("<th></th>").append(item.name);
            var loginName=$("<th></th>").append(item.loginName);
            var age=$("<th></th>").append(item.age);
            var sex=$("<th></th>").append(item.sex);
            var email=$("<th></th>").append(item.email);
            var department=$("<th></th>").append(item.department.deptName);
            var edidBtn=$("<button></button>").addClass("btn btn-primary btn-sm editBtn").attr("data-toggle","modal").attr("data-target","#updateUser").attr("user_ID",item.userId)
                .append($("<span><span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var deleBtn =$("<button></button>").addClass("btn btn-danger btn-sm deleBtn").attr("user_ID",item.userId)
                .append($("<span><span>").addClass("glyphicon glyphicon-trash")).append("删除");
            $("<tr></tr>").append(checkbox)
                .append(id)
                .append(name)
                .append(loginName)
                .append(age)
                .append(sex)
                .append(email)
                .append(department)
                .append(edidBtn)
                .append(deleBtn)
                .appendTo("#user_table tbody");
        })
    }

    //显示分布信息
    function showSplitPageMessage(result) {
        $("#show_page_basicInfo").empty();
        var currentPageNum = result.extend.pageInfo.pageNum;
        var allPageNum =result.extend.pageInfo.pages;
        var allDataNum =result.extend.pageInfo.total;
        var elementVal ="当前第"+currentPageNum+"页，总共"+allPageNum+"页，共有"+allDataNum+"条数据";
        $("#show_page_basicInfo").html(elementVal);
    }
    //显示页码信息
    function showPagesMessage(result) {
        $("#show_ul_Info").empty();
        var ul =$("#show_ul_Info");
        var firstElement =$("<li></li>").append($("<a></a>").prop("href","#").append("首页"));
        var preElement =$("<li></li>").append($("<a></a>").prop("href","#").append("&laquo;"));
      //当前为第一页
        if(result.extend.pageInfo.isFirstPage){
            firstElement.addClass("disabled");
            preElement.addClass("disabled");
        }else{
            //添加点击事件
            firstElement.click(function () {
                toPage(1);
            })
            preElement.click(function () {
                toPage(result.extend.pageInfo.pageNum-1);
            })
        }
        ul.append(firstElement).append(preElement);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi =$("<li></li>").append($("<a></a>").prop("href","#").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                toPage(item);
            })
            ul.append(numLi);
        })
        var nextElement =$("<li></li>").append($("<a></a>").prop("href","#").append("&raquo;"));
        var lastElement = $("<li></li>").append($("<a></a>").prop("href","#").append("末页"));
        //当前为最后一页
        if(result.extend.pageInfo.isLastPage){
            nextElement.addClass("disabled");
            lastElement.addClass("disabled");
        }else{
            //添加点击事件
            nextElement.click(function () {
                toPage(result.extend.pageInfo.pageNum+1);
            })
            lastElement.click(function () {
                toPage(result.extend.pageInfo.pages);
            })
        }
        ul.append(nextElement);
        ul.append(lastElement);
    }


    <!--获取所有部门-->
    function  getAllDepts(ele,id) {
        //清空表单内容与样式(增加用户时)
        if(ele=='#addUser'){
            cleanAddUserForm('#addUser form');
        }
        //发送请求获取所有部门
       $.ajax({
           url:"http://localhost:8080/getAllDepts",
           type:"POST",
           async : false,
           success:function (result) {
               $(ele+' select').empty();
              $.each(result.extend.depts,function (index,item) {
              //    alert(item);
                var selectOption= $("<option></option>").append(item.deptName).attr("value",item.deptId);
                selectOption.appendTo(ele+' select');
              })
           }
       })
        //如果为编辑，需要再交次发送请求，获取取当前id的信息，填入模态框
      //  alert("id:"+id);
        if(ele=='#updateUser'){
            $.ajax({
                url:"http://localhost:8080/getUser",
                type:"POST",
                data:"id="+id,
                async:false,
                success:function (result) {
                    var userData =result.extend.user;
                    $("#update_userID").val(userData.userId);
                    $("#update_name").val(userData.name);
                    $("#update_loginName").val(userData.loginName);
                    $("#update_loginPass").val(userData.loginPass);
                    $("#update_age").val(userData.age);
                    $("#update_email").val(userData.email);
                    $("#updateUser input[name=sex]").val([userData.sex]);
                    $("#updateUser select").val([userData.deptId]);
                }
            })



        }


    }
    <!--编辑按钮的事件-->
    $(document).on("click",".editBtn",function () {

        var userID =$(this).attr("user_ID");
        //alert(userID);
        //获取所有部门信息
        getAllDepts('#updateUser',userID);
    })
    <!--删除按钮的事件-->
    $(document).on("click",".deleBtn",function () {

        var userID =$(this).attr("user_ID");
       // alert(userID);
        //删除用户
        DeleteUser(userID);
    })

    <!--清空表单样式与内容-->
    function  cleanAddUserForm(ele) {
        //清空内容
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    <!--添加用户-->
    function  addUser() {
        var formData =($('#addUser form').serialize());
        formData = decodeURIComponent(formData,true);
        //检测数据的有效性
        if(!checkEmail('#email')||!checkAge('#age')||!checkLoginName('#loginName')||!checkPass('#loginPass')){
            alert("信息输入有误，请重新确认");
           return false;
        }
        //  alert(formData);
        $.ajax({
            url:"http://localhost:8080/addUser",
            type:"POST",
            data:formData,
            success:function (result) {
                //判断是否添加成功
                if(result.code==100){
                    alert("添加成功");
                    $('#addUser').modal('hide');
                }else{
                    //用户名重复时
                    if(!(result.extend.loginName==undefined)){
                        showValidateMessage('#loginName','不通过',result.extend.loginName);
                    };
                    //遍历错误字段
                    $.each(result.extend.errorFields,function (index,item) {
                        var elementID ="#"+index;
                        showValidateMessage(elementID,'不通过',item);
                    })
                }


            }
        })
    }
    <!--修改用户-->
    function  updateUser() {
        var formData =($('#updateUser form').serialize());
        formData = decodeURIComponent(formData,true);
        //检测数据的有效性
        if(!checkEmail('#update_email')||!checkAge('#update_age')||!checkPass('#update_loginPass')){
           alert("信息输入有误，请重新确认");
            return false;
        }
        //  alert(formData);
        $.ajax({
            url:"http://localhost:8080/updateUser",
            type:"POST",
            data:formData,
            success:function (result) {
            console.log(result);
                //判断是否添加成功
                if(result.code==100){
                    alert("更新成功");
                    $('#updateUser').modal('hide');
                }else{
                    //遍历错误字段
                    $.each(result.extend.errorFields,function (index,item) {
                        var elementID ="#update_"+index;
                        showValidateMessage(elementID,'不通过',item);
                    })
                }


            }
        })
    }
    <!-- 删除用户-->
    function  DeleteUser(id) {
        if(confirm("确认删除吗？")){
            $.ajax({
                url:"http://localhost:8080/deleteUser",
                data:"userId="+id,
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        alert("删除成功");
                    }else{
                        alert("删除失败");
                    }
                }
            })
        }


    }
    
    <!-- 模糊查询-->
    function searchUser() {
       toPage(1);
    }


    function  showValidateMessage(element,status,message) {
     //   alert("进入检测 ");
        $(element).parent().removeClass("has-error has-success");
        $(element).next("span").text("");
        if(status=="通过"){
            $(element).parent().addClass("has-success");
            $(element).next("span").text(message);
        }else{
            $(element).parent().addClass("has-error");
            $(element).next("span").text(message);
        }
    }
    function checkAge(element) {
        var elementValue =$(element).val();
        if(elementValue>=1&&elementValue<=150){
            showValidateMessage(element,"通过","");
            return true;
        }else{
            showValidateMessage(element,"不通过","非法年龄");
            return false;
        }

    }
    function checkPass(element) {
        var elementValue =$(element).val();
        if(elementValue!=""){
            showValidateMessage(element,"通过","");
            return true;
        }else{
            showValidateMessage(element,"不通过","密码不能为空");
            return false;
        }

    }
    function checkEmail(element) {
        var elementValue =$(element).val();
        var regxEmail =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(regxEmail.test(elementValue)){
            showValidateMessage(element,"通过","");
            return true;
        }else{
            showValidateMessage(element,"不通过","邮箱格式不正确");
            return false;
        }
    }

    //检查登录名是否重复
    function  checkLoginName(element) {
        var elementValue =$(element).val();
        if(elementValue=="") {
            showValidateMessage('#loginName','不通过','用户名不能为空');
            return false;
        }
       // alert(elementValue);
        var flag =false;
        $.ajax({
            url:"http://localhost:8080/checkLoginName",
            data:"loginName="+elementValue,
            type:"POST",
            async : false,
            success:function (result) {
              if(result.code==100){
                  showValidateMessage(element,'通过','用户名可用');
                  flag =true;
              }else{
                  showValidateMessage(element,'不通过','用户名已存在');
                  flag =false;
              }
            }
        })
        return flag;

    }
    
    //全选按钮逻辑实现
    $(document).on("click","#check_all",function () {
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function () {
        if($(".check_item:checked").length==$(".check_item").length){
            $("#check_all").prop("checked",true);
        }else{
            $("#check_all").prop("checked",false);
        }

    })

    //全选删除
    $(document).on("click","#delete_all_btn",function () {
        var deleteNumber =$(".check_item:checked").length;
        if(confirm("确认删除选中的"+deleteNumber+"个用户吗")){
            $.each($(".check_item:checked"),function () {
               var id = $(this).parents("tr").find("th:eq(1)").text();
                $.ajax({
                    url:"http://localhost:8080/deleteUser",
                    data:"userId="+id,
                    type:"POST",
                    async:false,
                    success:function (result) {

                    }
                })
            })
           alert("删除成功");
        }


    })

</script>


<div class="container">
    <!-- 标题-->
    <div class="row">
        <div class="col-md-12"><h1>用户管理</h1></div>
    </div>
    <!-- 按钮-->
    <div class="row" style="display:inline">
        <div class="col-md-6" >
            <div class="input-group" >
                <input type="text" class="form-control" id="searchString">
                <span class="input-group-btn">
						<button class="btn btn-primary" type="button" onclick="searchUser()">
							查询
						</button>
					</span>
            </div><!-- /input-group -->
        </div>
        <div class="col-md-6  col-md-offset-10" >
            <button class="btn btn-lg btn-primary" data-toggle="modal" data-target="#addUser" onclick="getAllDepts('#addUser',0)">新增</button>
            <button class="btn btn-lg btn-danger" id="delete_all_btn">删除</button>
        </div>

    </div>
    <!-- 显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="user_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>id</th>
                    <th>姓名</th>
                    <th>用户名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>

                </thead>
                <tbody>


                </tbody>



            </table>
        </div>

    </div>
    <!-- 显示分布信息-->
    <div class="row">
        <div class="col-md-6" id="show_page_basicInfo">

        </div>
        <div class="col-md-6">

            <ul class="pagination" id="show_ul_Info">

            </ul>


        </div>
    </div>
</div>
<!-- 用户修改模态框 -->
<div class="modal fade" id="updateUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" >
                    修改用户
                </h4>
            </div>
            <div class="modal-body">
                <!--内容部分 -->

                <form class="form-horizontal" role="form">
                    <input type="hidden" name="userId" id="update_userID">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_name" name="name" placeholder="请输入姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="loginName" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10 ">
                            <input  readonly  class="form-control" id="update_loginName" name="loginName" />
                            <span class="help-block"></span>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="loginPass" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_loginPass" name="loginPass" placeholder="请输入密码" onchange="checkPass('#update_loginPass')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_age" name="age" placeholder="请输入年龄" onchange="checkAge('#update_age')">
                            <span class="help-block"></span>
                        </div>

                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <label class="radio-inline  col-sm-2 col-sm-offset-1">
                            <input type="radio" name="sex"value="男" checked="true"> 男
                        </label>
                        <label class="radio-inline col-sm-2">
                            <input type="radio"  name="sex" value="女"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_email" name="email" placeholder="请输入邮箱" onchange="checkEmail('#update_email')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label for="dept_add_select" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-5">
                            <select class="form-control " name="deptId" id ="dept_update_select">
                            </select>
                        </div>
                    </div>

                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="updateUser()">
                    更新
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 用户添加模态框 -->
<div class="modal fade" id="addUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    添加用户
                </h4>
            </div>
            <div class="modal-body">
                <!--内容部分 -->

                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="loginName" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10 ">
                            <input type="text" class="form-control" id="loginName" name="loginName" placeholder="请输入用户名" onchange="checkLoginName('#loginName')">
                            <span class="help-block"></span>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="loginPass" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="loginPass" name="loginPass" placeholder="请输入密码" onchange="checkPass('#loginPass')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="age" name="age" placeholder="请输入年龄" onchange="checkAge('#age')">
                            <span class="help-block"></span>
                         </div>

                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <label class="radio-inline  col-sm-2 col-sm-offset-1">
                            <input type="radio" name="sex"value="男" checked="true"> 男
                        </label>
                        <label class="radio-inline col-sm-2">
                            <input type="radio"  name="sex" value="女"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱" onchange="checkEmail('#email')">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label for="dept_add_select" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-5">
                            <select class="form-control " name="deptId" id ="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="addUser()">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
