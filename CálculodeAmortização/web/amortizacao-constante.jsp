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
        
        <% double par = 0;%><!-- valor da parcela inicial -->
        <% double vpar = 0;%><!-- valor da parcela variante no mes -->
        <% double acum = 0;%><!-- apresentará o valor total do financiamento -->
        <% if (request.getParameter("calcular")!=null){ %>
            <% try{ %>
                <% double v = Double.parseDouble(request.getParameter("valor")); %>
                <% int m = Integer.parseInt(request.getParameter("mes")); %>
                <% double t = Double.parseDouble(request.getParameter("taxa")); %>
                <%  par = v/m;%>
                <%t = t/100;%><!-- Passando de porcentagem para decimal -->
                Valor financiado de R$ <%=v%><br/>
                Taxa mensal de <%=t%>%<br/>
                Em <%=m%> meses<br/><br/>
                <%double sd = v;%>
                <%double amortizacao = sd/m;%>
                <table border='0' style='text-align:center' align='center' cellspacing='0' cellpadding='4'>
                    <th width="3%">Parcela</th>
                    <th width="5%">Valor da Parcela</th>
                    <th width="5%">Juros</th>
                    <th width="5%">Amortização</th>
                    <th width="5%">Saldo devedor</th>
                </table>
                <% for (int i = 0; i<m; i++){ %>
                    <% double n = 0;%>
                    <% vpar = par + t*(v-(n*par)); %>
                    <% acum+=vpar;%>
                    
                    <table border='1' style='text-align:center' align='center' cellspacing='0' cellpadding='4'>
                        <tr bgcolor='#e0e0eb'>
                        <td width="3%">&nbsp; <%=i+1%> º</td><!-- Numero da parcela-->
                        <td width='5%'>&nbsp;  R$ <%=vpar%> </td><!-- Valor da parcela-->
                        <td width='5%'>&nbsp; <%out.print(String.format("%.2f",sd*t));%></td><!-- valor do Juros-->
                        <td width='5%'>&nbsp; <%out.print(String.format("%.2f",amortizacao));%></td><!-- valor do amortização--> 
                        <td width='5%'>&nbsp; <%=sd%></td><!-- valor do Saldo devedor--> 
                        </tr>
                    </table>
                    <%sd-=amortizacao;%>
                    <%n++;%>
                <%} %>
                <h3>O valor total do seu financiamento será de R$ <%out.print(String.format("%.2f",acum));%></h3>
            <%} catch(Exception e) { %>
                <h2>Dados inválidos</h2>
            <%}%>
            
        <%}%>   
        <%@include file="WEB-INF/jspf/footer.jspf"%>
    </body>
</html>
