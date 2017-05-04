<%-- 
    Document   : app
    Created on : 24-abr-2017, 19:11:15
    Author     : Adria Viñas
--%>

<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="model.bd.DAOTask"%>
<%@ page import="model.pojo.BeanTask"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css" />

        <title>Todolist App</title>
    </head>
    <body>
        <div id="nav-container">
            <nav class="navbar navbar-right navbar-toggleable-md navbar-light bg-faded">
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"  aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a class="navbar-brand ml-5" href="index.html">Todolist</a>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav">
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <%--<%
                                    /*String us = (String) request.getSession().getAttribute("sessuser");
                                    out.print(us);*/
                                %>--%>
                                <%= session.getAttribute("username") %>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="ControlLogin?action=logout">Logout</a>
                            </div>
                        </div>
                    </ul>
                </div>
            </nav>
        </div>

        <div class="container justify-content-center">
            <h1 class="text-center">Tasks</h1>

            <form class="form-inline mt-5" action="ControlTask?action=addTask" method="post">
                <div class="input-group col-md-6 offset-3">    

                    <input type="text" class="form-control" name="task" placeholder="Create a task" />

                    <span class="input-group-btn">
                        <button class="btn btn-secondary" type="submit">+</button><
                    </span>
                </div>
            </form>

        </div>        

        <div class="container mt-5">
            <div class="row">
                <div class="col-sm-8 offset-2">                    
                    <div id="accordion">
                        <%
                            int cont = 0;
                            DAOTask task = new DAOTask();
                            ArrayList<BeanTask> beanTask = task.getTasks();
                            Collections.reverse(beanTask);

                            if (task != null) {
                                out.println("<div id='accordion' role='tablist' aria-multiselectable='true' class='text-center'>");

                                for (BeanTask ts : beanTask) { 
                                    out.println("<div class='card' >"); 
                                    out.println("<div class='card-header role='tab' id=heading" + cont + " >");
                                    out.println("<h5 class='mb-0'>");
                                    out.println("<div class='d-flex justify-content-center'><a class='collapsed' data-toggle='collapse' data-parent='#accordion' href='#collapse" + cont + "' aria-expanded='false' aria-controls='collapse" + cont + "' >" + ts.getTask()+ "</a></div>");
                                    out.print("<div class='d-flex flex-row-reverse p-6'><span><a href=ControlTask?action=removeTask&id=");
                                        out.print( ts.getId() );
                                        out.println("><i class='fa fa-trash' aria-hidden='true'></i></a></span>");
                                    out.println("<span class='pr-3'><i class='fa fa-check' aria-hidden='true'></i></span>");
                                    out.println("<span class='pr-3 push-sm-3'><i class='fa fa-pencil' aria-hidden='true'></i></span></div>");
                                    out.println("</h5>");
                                    out.println("</div>");
                                    out.println("<div id='collapse" + cont + "' class='collapse' role='tabpanel' aria-labelledby=heading" + cont + " >");
                                  out.println("<div class='card-block'>");
                                    out.println("lalalalalalalala");
                                    out.println("</div>");
                                    out.println("</div>");
                                    out.println("</div>");
                                    cont++;
                                }

                                out.println("</div>");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    </body>
</html>
