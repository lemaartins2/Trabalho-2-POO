<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <%@include file="WEB-INF/jspf/vendor.jspf"%>
        <style>
            #main
            {
                padding: 10em;
            }
        </style>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf"%>

        <div id="main" class="container-fluid">
            <h1 class="text text-center">Seja bem-vindo ao nosso sistema de cálculo de amortização online!</h1>
            <h3 class="text text-center">Aqui você poderá realizar cálculos de amortização americana, amortização constante e tabela price.</h3>
        </div>
        
        <%@include file="WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
