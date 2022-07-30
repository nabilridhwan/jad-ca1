# JAD-CA1

## Branch naming convention
-	`ca2-dev`
	-	Branch for development for CA2
-	`master`
	-	Final release
-	`feature/xxx`
	-	A feature branch

## Defaults

```
Folder Name: CA1-Preparation (Not jad-ca1)

Admin Email: amy@admin.com
Admin Password: password

User Email: test@test.com
User Password: password
```

## Setting up the database

```
In _DatabaseConnectionConfig (in src/main/java/utils/_DatabaseConnectionConfig.java)
Please fill up the variables accordingly and remove underscore in the the file and the class name.
```

## Change the path of `file-upload` in `web.xml` found in `webapp/WEB-INF`
> This is for the image uploading feature

```xml

<web-app>

    <context-param>
        <description>Location to store uploaded file</description>
        <param-name>file-upload</param-name>
        <param-value>
            C:\Users\nabri\eclipse-workspace\CA1-Preparation\src\main\webapp\uploaded_images\
        </param-value>
    </context-param>

</web-app>
```

> The param-value should be inside the webapp/uploaded_images folder.

## Change every url (by default, not done)

Change every URL to include `/CA1-Preparation` in the path. This includes all the redirection and also to servlets.

```jsp

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>

// OR

<% request.getContextPath() + "/css/style.css" %>
```

## Include the navigation bar (if within views/.. folder)

```jsp
<%@ include file = "../misc/navbar.jsp" %>
```
