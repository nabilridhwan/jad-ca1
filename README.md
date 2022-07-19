# JAD-CA1

## Template folder

The template folder is where the template files are stored. It is located at `/src/main/webapp/template`. For every User
Story you are doing, make a template up in HTML and then make it into JSP.

## Defaults

```
Folder Name: CA1-Preparation (Not jad-ca1)

Admin Email: amy@admin.com
Admin Password: secret

User Email: test@test.com
User Password: secret
```

## Setting up the database

```
In _DatabaseConnectionConfig (in src/main/java/utils/_DatabaseConnectionConfig.java)
Please fill up the variables accordingly and rename the file to DatabaseConnectionConfig.java (remove the _)
```

## Change the path of upload images in `web.xml` found in `webapp/WEB-INF`

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

```html

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
```

## Include the navigation bar (if within views/.. folder)

```jsp
<%@ include file = "../misc/navbar.jsp" %>
```
