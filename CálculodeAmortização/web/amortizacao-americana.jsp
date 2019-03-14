<%-- 
    Document   : AmortizaçãoAmericana
    Created on : 13/03/2019, 19:33:29
    Author     : Leandro Martins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização Americana</title>
       
        
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf"%>
        <h1>Amortização Americana</h1>
        
         &emsp; Um sistema onde o valor da parcela é o juros mensal e a última pacerla carrega o valor financiado mais o juros do mês. <br/>
        Fórmula aplicada: <br/>
        <b>Parcelas = valor financiado * taxa de juros mensal<br/>
        Última parcela = valor financiado + (valor financiado * taxa de juros mensal)<br/>
        Total = nº de parcelas * parcelas + última parcela<br/></b>
        
        <h2>teste</h2><br/> 
        <form>
        Valor Financiado (R$) : <input type="text" name="valor"/><br/>
        <br/>
        Números de meses : <input type="text" name="mes"/><br/>
        <br/>
        Valor da taxa mensal (%)   : <input type="text" name="taxa"/><br/>
        <br/>
        <input type="submit" name="calcular" value="Cálcular"/>
        </form>
        <hr/>
        <% if (request.getParameter("calcular")!=null){ %>
            <% try{ %>
                <% float v = Float.parseFloat(request.getParameter("valor")); %>
                <% int m = Integer.parseInt(request.getParameter("mes")); %>
                <% float t = Float.parseFloat(request.getParameter("taxa")); %>
                <% float par = 0;%>
                <% float acum = 0;%>
                <%for (int i = 0; i<m-1; i++){%>
                    <%par = v*(t/100);%>
                    <%acum+=par;%>
                    &emsp;<%=i+1%>º Parcela = R$ <%=par%><br/>
                <%}%>
                &emsp;<%=m%>º Parcela = R$ <%=v+par%>
                <h3>&emsp;Valor total pago é de  R$ <%=acum+(v+par)%></h3>
            <%} catch(Exception e) { %>
                <h2>Dados inválidos</h2>
            <%}%>
        <%} %>
        
        <%@include file="WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
