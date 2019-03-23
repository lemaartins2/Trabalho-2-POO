<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Locale" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tabela Price</title>
    <%@include file="WEB-INF/jspf/vendor.jspf" %>
    <style>
        #main {
            padding: 1em;
        }

        #divisor {
            width: 80%;
            color: black;
            height: 2px;
            background-color: black;
        }
    </style>
</head>
<body>
<%@include file="WEB-INF/jspf/header.jspf" %>

<div id="main" class="container-fluid">
    <form method="post" action="#">
        <table class="table table-info table-bordered m-auto">
            <tr>
                <td colspan="2"><h1 class="text text-center m-3">Tabela Price</h1></td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>Também conhecido como sistema francês de amortização é um método usado em amortização e a
                        principal característica é apresentar parcelas iguais.</p>
                    <p>Fórmula aplicada:</p>
                    <ul>
                        <li>Parcelas = valor financiado x taxa de juros mensal / ( (1 + taxa de juros mensal) ^ meses - 1 )</li>
                    </ul>
                </td>
            </tr>
            <tr class="text text-center">
                <td class="text text-left"><label for="valor">Valor Financiado</label></td>
                <td><input id="valor" name="valor" type="text" size="50px"/></td>
            </tr>
            <tr class="text text-center">
                <td class="text text-left"><label for="meses">Meses</label></td>
                <td><input id="meses" name="meses" class="text text-right" type="text" size="50px"/></td>
            </tr>
            <tr class="text text-center">
                <td class="text text-left"><label for="taxa">Taxa Mensal</label></td>
                <td><input id="taxa" name="taxa" type="text" size="50px"/></td>
            </tr>
            <tr class="text text-center">
                <td colspan="2">
                    <input id="limpar" type="reset" name="limpar" value="Limpar" class="btn btn-danger m-3"/>
                    <input type="submit" name="calcular" value="Calcular" class="btn btn-primary"/>
                </td>
            </tr>
        </table>
    </form>

        <% if (request.getParameter("calcular")!=null) {
            try {
                double valor = Double.parseDouble(request.getParameter("valor"));
                double meses = Double.parseDouble(request.getParameter("meses"));
                double taxa = Double.parseDouble(request.getParameter("taxa"));
                double saldoDevedor = valor;
                taxa /= 100;
                double parcela = (valor * taxa) / (1 - (1 / Math.pow(1 + taxa, meses)));
                double amortizacao = 0;
                double jurosAcumulados = 0;
                double amortizacoesAcumuladas = 0;


                Locale.setDefault(new Locale("pt", "BR"));
                DecimalFormat monetario = new DecimalFormat("R$ #,##0.00");
                DecimalFormat porcentagem = new DecimalFormat("#0.00");%>

                <hr id="divisor"/>

                <table id="tabela" class="table table-dark table-bordered table-hover text-center">
                    <tr>
                        <td colspan="5">
                            <h1>Resultado</h1>
                            <p><b>Valor:</b> <%= monetario.format(valor)%></p>
                            <p><b>Meses:</b> <%= meses%></p>
                            <p><b>Taxa:</b> <%= porcentagem.format(taxa * 100)%> %</p>
                        </td>
                    </tr>
                    <tr>
                        <th>Parcela</th>
                        <th>Valor</th>
                        <th>Amortização</th>
                        <th>Juros</th>
                        <th>Saldo Devedor</th>
                    </tr>

                <%
                    for (int mes = 1; mes <= meses; mes++) {
                        double juros = taxa * saldoDevedor;
                        amortizacao = parcela - juros;
                        saldoDevedor -= amortizacao;
                        jurosAcumulados += juros;
                        amortizacoesAcumuladas += amortizacao;
                %>

                        <tr>
                            <td><%=(mes)%>º</td>
                            <td><%=monetario.format(parcela)%></td>
                            <td><%=monetario.format(amortizacao)%></td>
                            <td><%=monetario.format(juros)%></td>
                            <td><%=monetario.format(saldoDevedor)%></td>
                        </tr>

                    <%}%>

                    <tr>
                        <td>Total</td>
                        <td><%=monetario.format(parcela * meses)%></td>
                        <td><%=monetario.format(amortizacoesAcumuladas)%></td>
                        <td><%=monetario.format(jurosAcumulados)%></td>
                        <td></td>
                    </tr>
                </table>

            <%} catch (Exception e) { %>
                <h2 id="erro" class="text text-danger text-center m-5">Dados inválidos</h2>
            <%}%>
        <%}%>

    <%@include file="WEB-INF/jspf/footer.jspf" %>

    <script>
        $(document).ready(function () {
            $("#limpar").click(function () {
                $("#erro").remove();
                $("#tabela").remove();
                $("#divisor").remove();
            });

            $("#valor").inputmask("currency", {
                positionCaretOnClick: "ignore",
                radixPoint: ",",
                removeMaskOnSubmit: true,
                _radixDance: false,
                numericInput: true,
                unmaskAsNumber: true,
                prefix: "R$"
            });

            $("#meses").inputmask("integer", {
                numericInput: true,
                unmaskAsNumber: true,
                min: 1
            });

            $("#taxa").inputmask("decimal", {
                positionCaretOnClick: "ignore",
                radixPoint: ",",
                removeMaskOnSubmit: true,
                _radixDance: false,
                numericInput: true,
                unmaskAsNumber: true,
                suffix: " %"
            });
        });
    </script>
</body>
</html>
