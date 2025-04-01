
package com.security;


import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.game.classes.interfaces.jpa.UserRepository;
import com.game.classes.models.UserData;

public class CustomRealm extends JdbcRealm {
  @Autowired
  private UserRepository userRepository;

  @Override
  protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    String username = (String) principals.getPrimaryPrincipal();
    UserData user = userRepository.findByUsername(username).orElse(null);

    if (user != null) {
      SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
      info.addRole(user.getRole());
      return info;
    }

    return null;
  }

  @Override
  protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
      throws AuthenticationException {
    UsernamePasswordToken userToken = (UsernamePasswordToken) token;
    UserData user = userRepository.findByUsername(userToken.getUsername()).orElse(null);

    if (user != null) {
      return new SimpleAuthenticationInfo(user.getUsername(), user.getPassword(), getName());
    }

    throw new UnknownAccountException();
  }
}
