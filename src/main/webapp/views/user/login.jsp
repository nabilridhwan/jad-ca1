<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="ISO-8859-1">
        <title>DirEngine - Free Bootstrap 4 Template by Colorlib</title>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />

        <link
            href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
            rel="stylesheet"
        />
        <link
            href="https://fonts.googleapis.com/css?family=Alex+Brush"
            rel="stylesheet"
        />

        <link rel="stylesheet" href="/CA1-Preparation/css/open-iconic-bootstrap.min.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/animate.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/owl.carousel.min.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/owl.theme.default.min.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/magnific-popup.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/aos.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/ionicons.min.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/bootstrap-datepicker.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/jquery.timepicker.css" />

        <link rel="stylesheet" href="/CA1-Preparation/css/flaticon.css" />
        <link rel="stylesheet" href="/CA1-Preparation/css/icomoon.css" />
        <link rel="stylesheet" href="/CA1-Preparation/scss/style.css" />
    </head>
    <body>
    
    <%
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String error = "";
		
		if(email == null){
			email = "";
		}
		
		if(password == null){
			password = "";
		}
		
		if(request.getAttribute("error") != null){
			error = (String) request.getAttribute("error");
		}
	%>
	
	<%@ include file = "../misc/navbar.jsp" %>
	

        <div class="hero-wrap" style="background-image: url('/CA1-Preparation/images/bg_2.jpg')">
            <div class="overlay"></div>
            <div class="container">
                <div
                    class="row no-gutters js-fullheight align-items-center justify-content-center"
                    data-scrollax-parent="true"
                >
                    <section
                        class="ftco-section contact-section ftco-degree-bg bg-white rounded"
                    >
                        <div class="container px-5">
                            <div class="row d-flex contact-info">
                                <div class="col-md-12 mb-4">
                                    <h2 class="h4">Login</h2>
                                </div>
                                <div class="w-100"></div>
                                
                                <%if(!error.isEmpty()){%>
                                <div class="col-md-12">
                                    <p class="text-danger">
                                        Your credentials are incorrect
                                    </p>
                                </div>
                                <%}%>
                                
                            </div>

                            <div class="row block-9">
                                <div class="col-md-12">
                                
                                <!-- Form -->
                                    <form action="/CA1-Preparation/login" method="POST">
                                        <div class="form-group">
                                            <input
                                                type="text"
                                                class="form-control"
                                                placeholder="Email"
                                                name="email" 
                                                value="<%=email %>"
                                            />
                                        </div>
                                        <div class="form-group">
                                            <input
                                                type="password"
                                                class="form-control"
                                                placeholder="Password"
                                                name="password"
                                                value="<%=password %>"
                                            />
                                        </div>
                                        <div class="form-group">
                                            <input
                                                type="submit"
                                                value="Login"
                                                class="btn w-100 btn-primary py-3 px-5"
                                            />
                                        </div>

                                        <div class="form-group text-dark">
                                            <p>
                                                Don't have an account?
                                                <a href="">Sign Up</a>
                                            </p>
                                        </div>
                                    </form>
                                </div>
                                <!-- <div class="col-md-6" id="map"></div> -->
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <footer class="ftco-footer ftco-bg-dark ftco-section">
            <div class="container">
                <div class="row mb-5">
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">dirEngine</h2>
                            <p>
                                Far far away, behind the word mountains, far
                                from the countries Vokalia and Consonantia,
                                there live the blind texts.
                            </p>
                            <ul
                                class="ftco-footer-social list-unstyled float-md-left float-lft mt-5"
                            >
                                <li class="ftco-animate">
                                    <a href="#"
                                        ><span class="icon-twitter"></span
                                    ></a>
                                </li>
                                <li class="ftco-animate">
                                    <a href="#"
                                        ><span class="icon-facebook"></span
                                    ></a>
                                </li>
                                <li class="ftco-animate">
                                    <a href="#"
                                        ><span class="icon-instagram"></span
                                    ></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4 ml-md-5">
                            <h2 class="ftco-heading-2">Information</h2>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#" class="py-2 d-block">About</a>
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block">Service</a>
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Terms and Conditions</a
                                    >
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Become a partner</a
                                    >
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Best Price Guarantee</a
                                    >
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Privacy and Policy</a
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Customer Support</h2>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#" class="py-2 d-block">FAQ</a>
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Payment Option</a
                                    >
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Booking Tips</a
                                    >
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >How it works</a
                                    >
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block"
                                        >Contact Us</a
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Have a Questions?</h2>
                            <div class="block-23 mb-3">
                                <ul>
                                    <li>
                                        <span
                                            class="icon icon-map-marker"
                                        ></span
                                        ><span class="text"
                                            >203 Fake St. Mountain View, San
                                            Francisco, California, USA</span
                                        >
                                    </li>
                                    <li>
                                        <a href="#"
                                            ><span
                                                class="icon icon-phone"
                                            ></span
                                            ><span class="text"
                                                >+2 392 3929 210</span
                                            ></a
                                        >
                                    </li>
                                    <li>
                                        <a href="#"
                                            ><span
                                                class="icon icon-envelope"
                                            ></span
                                            ><span class="text"
                                                >info@yourdomain.com</span
                                            ></a
                                        >
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            All rights reserved | This template is made with
                            <i class="icon-heart" aria-hidden="true"></i> by
                            <a href="https://colorlib.com" target="_blank"
                                >Colorlib</a
                            >
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen">
            <svg class="circular" width="48px" height="48px">
                <circle
                    class="path-bg"
                    cx="24"
                    cy="24"
                    r="22"
                    fill="none"
                    stroke-width="4"
                    stroke="#eeeeee"
                />
                <circle
                    class="path"
                    cx="24"
                    cy="24"
                    r="22"
                    fill="none"
                    stroke-width="4"
                    stroke-miterlimit="10"
                    stroke="#F96D00"
                />
            </svg>
        </div>

        <script src="/CA1-Preparation/js/jquery.min.js"></script>
        <script src="/CA1-Preparation/js/jquery-migrate-3.0.1.min.js"></script>
        <script src="/CA1-Preparation/js/popper.min.js"></script>
        <script src="/CA1-Preparation/js/bootstrap.min.js"></script>
        <script src="/CA1-Preparation/js/jquery.easing.1.3.js"></script>
        <script src="/CA1-Preparation/js/jquery.waypoints.min.js"></script>
        <script src="/CA1-Preparation/js/jquery.stellar.min.js"></script>
        <script src="/CA1-Preparation/js/owl.carousel.min.js"></script>
        <script src="/CA1-Preparation/js/jquery.magnific-popup.min.js"></script>
        <script src="/CA1-Preparation/js/aos.js"></script>
        <script src="/CA1-Preparation/js/jquery.animateNumber.min.js"></script>
        <script src="/CA1-Preparation/js/bootstrap-datepicker.js"></script>
        <script src="/CA1-Preparation/js/jquery.timepicker.min.js"></script>
        <script src="/CA1-Preparation/js/scrollax.min.js"></script>
        <script src="/CA1-Preparation/js/main.js"></script>
    </body>
</html>
