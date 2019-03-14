<%-- 
    Document   : AmortizaçãoConstante
    Created on : 13/03/2019, 19:32:49
    Author     : Leandro Martins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização Constante</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf"%>
        <h1>Amortização Constante</h1>
        É conhecido como Tabela SAC, onde as parcelas tem valores <b>decrescentes</b>. <br/><br/>
        Fórmula aplicada : <br/><b>parcela = amortização + jurosSobreSaldoDevedor</b><br/>
        
        <hr/><br/>
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
        
        <% float par = 0;%><!-- valor da parcela inicial -->
        <% float vpar = 0;%><!-- valor da parcela variante no mes -->
        <% float acum = 0;%><!-- apresentará o valor total do financiamento -->
        <% if (request.getParameter("calcular")!=null){ %>
            <% try{ %>
                <% float v = Float.parseFloat(request.getParameter("valor")); %>
                <% int m = Integer.parseInt(request.getParameter("mes")); %>
                <% float t = Float.parseFloat(request.getParameter("taxa")); %>
                <% par = v/m;%>
                Valor financiado de R$ <%=v%><br/>
                Taxa mensal de <%=t%>%<br/>
                Em <%=m%> meses<br/><br/>
                
                <% for (int i = 0; i<m; i++){ %>
                    <% vpar = par + t*(v-(i*par)); %>
                    <% acum+=vpar;%>
                    &nbsp; <%=i+1%>º Parcela tem valor de R$<%out.print(String.format("%.2f",vpar));%><br/>
                <%} %>
                <h3>O valor total do seu financiamento será de R$ <%out.print(String.format("%.2f",acum));%></h3>
            <%} catch(Exception e) { %>
                <h2>Dados inválidos</h2>
            <%}%>
            
        <%}%>   
        <%@include file="WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
