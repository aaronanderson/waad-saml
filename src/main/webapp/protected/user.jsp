<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,org.picketlink.common.constants.GeneralConstants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>WAAD SAML - Post Authentication</title>
</head>
<body>
    <div align="center">
        <h1>WAAD SAML Post Authentication</h1>
        <br />
        Principal:
        <%=request.getUserPrincipal().getName()%>
        <%   Map<String, List<Object>> attrs = (Map<String, List<Object>>)session.getAttribute(GeneralConstants.SESSION_ATTRIBUTE_MAP); %>
        <br />
        First Name:
        <%=attrs.get("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname")%>
        <br />
        Last Name:
         <%=attrs.get("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname")%>
        <%--<br />
         In Local Role:
         <%= request.isUserInRole("local-role") %> --%>
        <br />
        <br />
        <a href="?GLO=true">Click to LogOut</a>
    </div>
</body>
</html>