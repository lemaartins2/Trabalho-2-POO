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
        <div id="main" class="container-fluid">
            <h1 class="text text-center">SISTEMA DE AMORTIZAÇÃO ONLINE!</h1>
            <h3 class="text text-center">VOCÊ SERÁ REDIRECIONADO PARA O SISTEMA EM <span id="contador">10</span> SEGUNDOS...</h3>
        </div>

        <script>
            var count = 10;
            setInterval(function(){
                count--;
                document.getElementById('contador').innerHTML = count;
                if (count === 1) {
                    window.location.href = 'home.jsp';
                }
            },1000);
        </script>
    </body>
</html>
