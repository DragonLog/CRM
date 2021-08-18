package com.zcx.crm.web.filter;

import com.zcx.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {    //全局过滤器
    @Override
    public void init(FilterConfig filterConfig) {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getServletPath();
        if ("/login.jsp".equals(path) || "/settings/user/login.do".equals(path)) {
            filterChain.doFilter(request, response);
        } else {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user != null) {
                filterChain.doFilter(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }
    }

    @Override
    public void destroy() {

    }
}
