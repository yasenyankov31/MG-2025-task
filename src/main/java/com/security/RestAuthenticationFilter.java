package com.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.web.filter.authc.AuthenticationFilter;
import net.minidev.json.JSONObject;

public class RestAuthenticationFilter extends AuthenticationFilter {

  @Override
  protected boolean onAccessDenied(ServletRequest request, ServletResponse response)
      throws Exception {
    HttpServletResponse httpServletResponse = (HttpServletResponse) response;
    httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    httpServletResponse.setContentType("application/json");

    JSONObject jsonResponse = new JSONObject();
    jsonResponse.put("message", "User is not authenticated");
    response.getWriter().write(jsonResponse.toString());

    return false; // Stop further processing
  }


}
