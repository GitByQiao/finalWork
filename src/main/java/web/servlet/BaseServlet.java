package web.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;


public class BaseServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获得请求的地址名
        String requestURI = req.getRequestURI();/*    /finalWork/brand    */
        //获得最后名字做为方法名
        int index = requestURI.lastIndexOf("/");
        String s = requestURI.substring(index + 1);
        System.out.println(s);
        //获得继承本类的类的class对象
        Class<? extends BaseServlet> aClass = this.getClass();
        try {
            //获得子类的方法
            //第一个参数为方法名,第二个参数为形参的class对象
            Method method = aClass.getMethod(s,HttpServletRequest.class,HttpServletResponse.class);
            //执行本类的方法
            //第一个参数为哪个类,第二个参数为实参
            method.invoke(this,req,resp);
        } catch (NoSuchMethodException | InvocationTargetException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
