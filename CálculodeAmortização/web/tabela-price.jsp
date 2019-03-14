<%-- 
    Document   : TabelaPrice
    Created on : 13/03/2019, 19:34:05
    Author     : Leandro Martins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Tabela Price</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf"%>
        <h1>Tabela Price</h1>
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
        <% if (request.getParameter("calcular")!=null){%>
            <% double v = Double.parseDouble(request.getParameter("valor")); %>
                <% double m = Double.parseDouble(request.getParameter("mes")); %>
                <% double t = Double.parseDouble(request.getParameter("taxa")); %>
                <% double vr = v; %>
                <% t=t/100;%>
                <% double par = v*(((Math.pow((1+t),m)*t))/(((Math.pow((1+t),m)-1))));%>
                 Valor da Prestação é R$ <%out.print(String.format("%.2f",par));%><br/>   
                 Valor Total  do financiamento R$ <%out.print(String.format("%.2f",par*12));%> <br/>
                   <table border='0' style='text-align:center' align='center' cellspacing='0' cellpadding='4'>
                     <tr>
                     <th width ="3%">Parcela</th>
                     <th width ="5%">Valor da Prestação</th>
                     <th width ="5%">Amortização</th>
                     <th width ="5%">Juros</th>
                     <th width ="5%">Saldo Devedor</th>
                     </tr>
                   </table>
                 <%for (int i = 0; i < m; i++){%>               
                 <table border='1' style='text-align:center' align='center' cellspacing='0' cellpadding='4'>
                     <tr>
                     <tbody>
                         <td width ="3%"><%=(i+1)%></td><!-- número da parcela -->
                         <td width ="5%">&emsp;&emsp;<%out.print(String.format("%.2f",par));%></td><!-- Valor da parcela (fixo neste sistema) -->
                         <%double amortizado = par -(t*vr);%>
                         <td width ="5%">&emsp;&emsp;<%out.print(String.format("%.2f",amortizado));%></td><!-- Valor amotizado -->
                         <td width ="5%">&emsp;&emsp;<%out.print(String.format("%.2f",(t*vr)));%></td><!-- Valor do juros naquele mês -->
                         <td width ="5%">&emsp;&emsp;<%out.print(String.format("%.2f",vr- amortizado));%></td><!-- Valor do saldo devedor -->
                     </tbody>
                     </tr>
                     <%vr -=amortizado; %>                    
                 </table>
                 <%}%>
        <%}%>
        <%@include file="WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
