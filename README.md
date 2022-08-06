# Tours R' Us

## Branch naming convention
-	`ca2-dev`
	-	Branch for development for CA2
-	`master`
	-	Final release
-	`feature/xxx`
	-	A feature branch

## Features
-   Password Hashing via BCrypt (No way you're gonna crack this!)
-   Consuming external API (Currency Conversion API)
-   Using Cloudinary as a storage for all the images (category and tour)
-   Stripe payment handles all the payment process (credit card, paypal, etc)
    -   This allows us to get the transaction details and the status to better keep track.
-   Modification of the tour (edit, delete, etc)

## Defaults

```
Folder Name: CA1-Preparation (Not jad-ca1)

Admin Email: amy@admin.com
Admin Password: password

User Email: test@test.com
User Password: password

Database name: jad
```

## Setting up the database
-   Restore the dump file CA2_dump.sql to the database under the database name `jad`.
-   In _DatabaseConnectionConfig (in src/main/java/utils/_DatabaseConnectionConfig.java)
    -   Please fill up the variables accordingly and remove underscore in the the file and the class name.

## Grabbing an API key for the Exchange Currency
For the exchange of currency to work, you need to get an API key for the Exchange Currency.
1.  Grab an API key from here: https://apilayer.com/marketplace/exchangerates_data-api#documentation-tab.
2.  Open up the `jad-ca2-webservice` folder and change the following line inside `src/main/java/webservices/CurrencyConversion.java`
    ```java
    Response resp = invocationBuilder.header("apikey", "<API_KEY_HERE>").get();
    ```

## Grabbing a Stripe API key for the Stripe Payment
For the Stripe payment to work, you need to get an API key for the Stripe Payment.
1.  Create a Stripe account here: https://dashboard.stripe.com/register.
2.  After signing up, head over to the API keys section (https://dashboard.stripe.com/test/apikeys).
3.  Take note of both your publishable and secret keys.

### Configuring JAD-CA1
1.  Under `src/java/main` folder
    -   In `payment/StripePayment.java` and `webservices/StripeCheckoutController.java`
        -   Change every line that looks like this: `Stripe.apiKey = "<SECRET_HERE>";` to your **secret** API Key.
2.  Under `src/main/webapp/views`
    -   In `payment/checkout.jsp`
        -   Change the line `const stripe = Stripe('<PUBLISHABLE_HERE>');` to your **publishable** API Key.

## Grabbing a Cloudinary _credential details_ for image uploading function
For the image uploading function to work, you need to get the credentials for the Cloudinary API.
1. Grab your credentials from here: https://cloudinary.com/console/settings_images.
2.  In `src/main/java/cloudinary/ImageUpload.java`, change the whole chunk to match your credentials.
    ```java
    public static Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
			"cloud_name", "<CLOUD_NAME>",
			"api_key", "<API_KEY>",
			"api_secret", "<API_SECRET>",
			"secure", true));
    ```

## Change the path of `file-upload` in `web.xml` found in `webapp/WEB-INF`
> This is for the image uploading feature, it is important to change it. The path should be an accessible path not behind adminitrator's control. Place the full path under `<param-value>`

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

## Change every url (by default, not done)

Change every URL to include the context path so that it is dynamic. This includes all the redirection and also to servlets.

```jsp

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>

// OR

<% request.getContextPath() + "/css/style.css" %>
```

## Include the navigation bar (if within views/.. folder)

```jsp
<%@ include file = "../misc/navbar.jsp" %>
```
