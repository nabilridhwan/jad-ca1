# JAD-CA1

## Template folder

The template folder is where the template files are stored. It is located at `/src/main/webapp/template`. For every User Story you are doing, make a template up in HTML and then make it into JSP.

## Change every url (by default, not done)

Change every URL to include `/CA1-Preparation` in the path. This includes all the redirection and also to servlets.

```html
<link rel="stylesheet" href="/CA1-Preparation/css/style.css" />
```

## Include the navigation bar (if within views/.. folder)

```jsp
<%@ include file = "../misc/navbar.jsp" %>
```
