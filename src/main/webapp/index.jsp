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


    <!--获取所有部门-->
    function  getAllDepts() {
       $.ajax({
           url:"http://localhost:8080/getAllDepts",
           type:"POST",
           success:function (result) {
               $('#dept_add_select').empty();
              $.each(result.extend.depts,function (index,item) {
              //    alert(item);
                var selectOption= $("<option></option>").append(item.deptName).attr("value",item.deptId);
                selectOption.appendTo("#dept_add_select");
              })
           }
       })
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
                if(result.msg=="处理成功"){
                    alert("添加成功");
                }else{
                    alert("添加失败")
                }
                $('#addUser').modal('hide');
            }
        })
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
            showValidateMessage(element,"不通过","年龄只能是一到两位的数字");
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
                  showValidateMessage('#loginName','通过','用户名可用');
                  flag =true;
              }else{
                  showValidateMessage('#loginName','不通过','用户名重复');
                  flag =false;
              }
            }
        })
        return flag;

    }

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
                <input type="text" class="form-control">
                <span class="input-group-btn">
						<button class="btn btn-primary" type="button">
							查询
						</button>
					</span>
            </div><!-- /input-group -->
        </div>
        <div class="col-md-6  col-md-offset-10" >
            <button class="btn btn-lg btn-primary" data-toggle="modal" data-target="#addUser" onclick="getAllDepts()">新增</button>
            <button class="btn btn-lg btn-danger">删除</button>
        </div>

    </div>
    <!-- 显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>id</th>
                    <th>姓名</th>
                    <th>用户名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${message.extend.pageInfo.list}" var="user">
                    <tr>
                        <th>${user.userId}</th>
                        <th>${user.name}</th>
                        <th>${user.loginName}</th>
                        <th>${user.age}</th>
                        <th>${user.sex}</th>
                        <th>${user.email}</th>
                        <th>${user.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑</button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除</button>

                        </th>
                    </tr>

                </c:forEach>

            </table>
        </div>

    </div>
    <!-- 显示分布信息-->
    <div class="row">
        <div class="col-md-6">
            当前第${message.extend.pageInfo.pageNum}页,总共${message.extend.pageInfo.pages}页,总共${message.extend.pageInfo.total}条纪录
        </div>
        <div class="col-md-6">

            <ul class="pagination">
                <li><a href="/getAllUsers?pageNum=1">首页</a></li>
                <c:if test="${!message.extend.pageInfo.isFirstPage}">
                    <li><a href="/getAllUsers?pageNum=${message.extend.pageInfo.pageNum-1}">&laquo;</a></li>
                </c:if>

                <c:forEach items="${message.extend.pageInfo.navigatepageNums}" var="page_Num">
                    <c:if test="${page_Num==message.extend.pageInfo.pageNum}">
                        <li class="active"><a href="#">${page_Num}</a></li>
                    </c:if>
                    <c:if test="${page_Num!=message.extend.pageInfo.pageNum}">
                        <li ><a href="/getAllUsers?pageNum=${page_Num}">${page_Num}</a></li>
                    </c:if>

                </c:forEach>
                <c:if test="${!message.extend.pageInfo.isLastPage}">
                    <li><a href="/getAllUsers?pageNum=${message.extend.pageInfo.pageNum+1}">&raquo;</a></li>
                </c:if>

                <li><a href="/getAllUsers?pageNum=${message.extend.pageInfo.pages}">末页</a></li>
            </ul>


        </div>
    </div>
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
                            <input type="text" class="form-control" id="email" placeholder="请输入邮箱" onchange="checkEmail('#email')">
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
